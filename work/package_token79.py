"""Package the Teste79 source changes in their original project paths."""
from pathlib import Path
import hashlib
import json
import os
import tempfile
import zipfile

root = Path(__file__).resolve().parents[1]
folder = root / 'work/feature79'
release = json.loads((folder / 'release79.json').read_text())
validation = json.loads((folder / 'validation79.json').read_text())
assert release['swfSha256'] == validation['swfSha256']
assert 'PASS: APK v1/v2' in (folder / 'apk-signature.log').read_text()

files = ['work/PatchToken79.java', 'work/VerifyToken79.java',
         'work/AuditToken79.java', 'work/README_TOKEN79.md', 'work/build_token79.sh',
         'work/make_token_apk79.py', 'work/regression_token79.py', 'work/package_token79.py',
         'work/HabboTablet_Token79_Base33.swf']
files += [f'work/feature79/{name}' for name in ['release79.json', 'validation79.json', 'apk-signature.log']]
files += [f'work/feature79/test-{name}.log' for name in validation['checks']]
target = root / 'output/Habbo_Teste79_Base33_Alteracoes.zip'
with tempfile.TemporaryDirectory(dir=folder) as temp:
    temporary = Path(temp) / 'release.zip'
    with zipfile.ZipFile(temporary, 'w', zipfile.ZIP_DEFLATED, compresslevel=6) as archive:
        for path in files:
            archive.write(root / path, path)
    with zipfile.ZipFile(temporary) as archive:
        assert archive.testzip() is None and archive.namelist() == files
        assert hashlib.sha256(archive.read('work/HabboTablet_Token79_Base33.swf')).hexdigest() == release['swfSha256']
    os.replace(temporary, target)
target.chmod(0o644)
(root / 'output/Habbo_2.32.44_Teste79_Base33.apk').chmod(0o644)
print(f'PASS: {len(files)} changed files in {target.name}')
