#!/usr/bin/env bash
#
# agent-craft-cn 安装 / 卸载脚本
#
set -euo pipefail

SCRIPT_VERSION="0.1.0"
REPO="TTNAN/agent-craft-cn"
REF="main"
TARGET="claude"
SKILL="all"
UNINSTALL=0
LEGACY=0

# 本包自带的 skill 名（卸载时只删这些，不动用户的其他 skill）
OUR_SKILLS="clarify-first plan-before-code tdd-red-green review-five-axes debug-like-detective refactor-small-steps write-chinese-docs retrospective using-agent-craft"
BACKUP_ROOT="$HOME/.agent-craft-cn-backup"
MARKER=".installed-by-agent-craft-cn"

usage() {
cat <<'HELP_EOF'
agent-craft-cn 安装 / 卸载脚本

安装（默认装全部 9 个 skill 到 Claude Code）:
  curl -fsSL https://raw.githubusercontent.com/TTNAN/agent-craft-cn/main/install.sh | bash

常用变体:
  bash -s -- --target codex            # 装到 Codex（~/.agents/skills，新版官方目录）
  bash -s -- --target codex --legacy   # 另装旧版 ~/.codex/skills（兼容老版本 Codex）
  bash -s -- --target all              # Claude Code 和 Codex 都装
  bash -s -- --skill tdd-red-green     # 只装某一个 skill
  bash -s -- --ref v0.1.0              # 指定版本安装
  bash -s -- --uninstall               # 卸载（只删本包的 skill，不动你自己的）

已有同名 skill 时:
  - 是本包之前装的：直接覆盖，不备份
  - 是你自己的（比如你手写的 retrospective）：挪到 ~/.agent-craft-cn-backup/，不会丢

参数:
  --target <claude|codex|all>   装到哪个 Agent（默认 claude）
  --skill <name|all>            只装某一个 skill（默认 all）
  --ref <branch|tag|commit>     指定版本（默认 main）
  --legacy                      Codex 额外装旧版 ~/.codex/skills 目录
  --uninstall                   卸载本包的 skill
  -h, --help                    显示本帮助
HELP_EOF
}

need_value() { # $1=flag, $2=value
  if [[ -z "${2:-}" || "$2" == -* ]]; then
    echo "错误：$1 后面要跟一个值（用 --help 看用法）" >&2
    exit 1
  fi
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    -h|--help) usage; exit 0 ;;
    --uninstall) UNINSTALL=1; shift ;;
    --legacy) LEGACY=1; shift ;;
    --target) need_value "$1" "${2:-}"; TARGET="$2"; shift 2 ;;
    --skill)  need_value "$1" "${2:-}"; SKILL="$2";  shift 2 ;;
    --ref)    need_value "$1" "${2:-}"; REF="$2";    shift 2 ;;
    *) echo "未知参数: $1（用 --help 看用法）" >&2; exit 1 ;;
  esac
done

case "$TARGET" in
  claude|codex|all) ;;
  *) echo "错误：--target 必须是 claude / codex / all" >&2; exit 1 ;;
esac

# 目标目录：每行 "标签 目录"。Codex 默认只装新版官方目录，加 --legacy 才装旧版。
dest_dirs() {
  if [[ "$TARGET" == "claude" || "$TARGET" == "all" ]]; then
    echo "claude $HOME/.claude/skills"
  fi
  if [[ "$TARGET" == "codex" || "$TARGET" == "all" ]]; then
    echo "agents $HOME/.agents/skills"
    if [[ "$LEGACY" == "1" ]]; then
      echo "codex $HOME/.codex/skills"
    fi
  fi
}

# ---- 卸载：只删本包的 skill ----
if [[ "$UNINSTALL" == "1" ]]; then
  names="$OUR_SKILLS"
  [[ "$SKILL" != "all" ]] && names="$SKILL"
  while read -r _label dir; do
    for n in $names; do
      if [[ -f "$dir/$n/$MARKER" ]]; then
        rm -rf "$dir/$n"
        echo "已删除 $dir/$n"
      elif [[ -e "$dir/$n" ]]; then
        echo "跳过 $dir/$n（不是本包装的，不动）"
      fi
    done
  done < <(dest_dirs)
  echo "卸载完成。"
  exit 0
fi

AC_WORKDIR="$(mktemp -d)"
trap 'rm -rf "$AC_WORKDIR"' EXIT

echo "==> 下载 agent-craft-cn@$REF ..."
curl -fsSL "https://github.com/${REPO}/archive/${REF}.tar.gz" -o "$AC_WORKDIR/repo.tar.gz"
tar -xzf "$AC_WORKDIR/repo.tar.gz" -C "$AC_WORKDIR"
# 不把解压目录名写死：tag 会去掉开头的 v，分支名带 / 也会变，glob 最稳
SRC="$(echo "$AC_WORKDIR"/*/skills)"

if [[ "$SKILL" != "all" && ! -d "$SRC/$SKILL" ]]; then
  echo "错误：找不到 skill '$SKILL'"
  echo "可用 skill："
  ls "$SRC"
  exit 1
fi

TS="$(date +%Y%m%d%H%M%S)"

install_one() { # $1=标签 $2=目标目录 $3=skill 名
  local label="$1" dest="$2" n="$3"
  mkdir -p "$dest"
  if [[ -e "$dest/$n" ]]; then
    if [[ -f "$dest/$n/$MARKER" ]]; then
      # 本包之前装的：直接覆盖，不备份
      rm -rf "$dest/$n"
    else
      # 用户自己的 skill：挪到备份目录，不能留在 skills 里（会跟新版同时被加载）
      local bak="$BACKUP_ROOT/$TS/$label-$n"
      mkdir -p "$BACKUP_ROOT/$TS"
      mv "$dest/$n" "$bak"
      echo "  注意：$dest/$n 不是本包装的，已备份到 $bak"
    fi
  fi
  cp -r "$SRC/$n" "$dest"/
  echo "$SCRIPT_VERSION" > "$dest/$n/$MARKER"
  echo "==> 已安装 $n 到 $dest"
}

names="$OUR_SKILLS"
[[ "$SKILL" != "all" ]] && names="$SKILL"
while read -r label dir; do
  for n in $names; do
    install_one "$label" "$dir" "$n"
  done
done < <(dest_dirs)

echo ""
echo "完成（脚本版本 $SCRIPT_VERSION）。"
echo "重启你的 Agent（或开新会话）后 skill 自动生效。"
echo "查看：ls ~/.claude/skills ~/.agents/skills"
echo "卸载：curl -fsSL https://raw.githubusercontent.com/TTNAN/agent-craft-cn/main/install.sh | bash -s -- --uninstall"
