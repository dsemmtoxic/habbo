"""Fetch pinned public build tools, or check an existing installation."""
from pathlib import Path
import hashlib, io, json, sys, urllib.request, zipfile
ROOT = Path(__file__).resolve().parents[1]
manifest = json.loads((ROOT / 'work/feature63/dependencies63.json').read_text())
expected = manifest['sha256']
def valid(name):
    target = ROOT / name
    return target.is_file() and hashlib.sha256(target.read_bytes()).hexdigest() == expected[name]
def checked_write(name, data):
    if hashlib.sha256(data).hexdigest() != expected[name]:
        raise ValueError('Public dependency checksum differs: ' + name)
    target = ROOT / name
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_bytes(data)
def fetch(url):
    request = urllib.request.Request(url, headers={'User-Agent': 'Habbo-Token61-build'})
    with urllib.request.urlopen(request, timeout=60) as response:
        return response.read()
if '--check' not in sys.argv:
    flash = [n for n in expected if n.startswith('.task-tools/ffdec/')]
    if not all(valid(n) for n in flash):
        with zipfile.ZipFile(io.BytesIO(fetch(manifest['ffdecUrl']))) as archive:
            for name in flash:
                checked_write(name, archive.read(name.removeprefix('.task-tools/ffdec/')))
            for name in ['license.txt', 'CHANGELOG.md']:
                target = ROOT / '.task-tools/ffdec' / name
                target.write_bytes(archive.read(name))
    for name, urlkey in [('.task-tools/apktool61.jar', 'apktoolUrl'), ('.task-tools/apksig61.jar', 'apksigUrl')]:
        if not valid(name):
            checked_write(name, fetch(manifest[urlkey]))
missing = [n for n in expected if not valid(n)]
if missing:
    raise SystemExit('Missing or changed build tools: ' + ', '.join(missing))
print('PASS: pinned FFDec26.4.0 and libraries, Apktool3.0.3 and apksig8.10.1.')
