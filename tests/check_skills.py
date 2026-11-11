"""Check every skills/*/SKILL.md has valid YAML frontmatter with name and description."""
import pathlib, re, sys
import yaml

root = pathlib.Path(__file__).resolve().parent.parent
bad = 0
files = sorted(root.glob("skills/*/SKILL.md"))
for f in files:
    text = f.read_text(encoding="utf-8")
    m = re.match(r"^---\r?\n(.*?)\r?\n---", text, re.S)
    try:
        fm = yaml.safe_load(m.group(1)) if m else None
        assert isinstance(fm, dict), "missing frontmatter"
        assert fm.get("name") == f.parent.name, f"name should be {f.parent.name}"
        assert isinstance(fm.get("description"), str) and fm["description"].strip(), "empty description"
    except Exception as e:
        bad += 1
        print(f"FAIL {f.relative_to(root)}: {e}")
print(f"{len(files) - bad}/{len(files)} skills OK")
sys.exit(1 if bad or not files else 0)
