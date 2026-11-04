"""Package the Teste78 source changes in their original project paths."""
from pathlib import Path
import hashlib
import json
import os
import tempfile
import zipfile

root = Path(__file__).resolve().parents[1]
folder = root / 'work/feature78'
release = json.loads((folder / 'release78.json').read_text())
validation = json.loads((folder / 'validation78.json').read_text())
assert release['swfSha256'] == validation['swfSha256']
assert 'PASS: APK v1/v2' in (folder / 'apk-signature.log').read_text()

files = ['work/AvatarClick78.as', 'work/PatchToken78.java', 'work/VerifyToken78.java',
         'work/AuditToken78.java', 'work/README_TOKEN78.md', 'work/build_token78.sh',
         'work/make_token_apk78.py', 'work/regression_token78.py', 'work/package_token78.py',
         'work/HabboTablet_Token78_Base33.swf']
files += [f'work/feature78/{name}' for name in ['release78.json', 'validation78.json', 'apk-signature.log']]
files += [f'work/feature78/test-{name}.log' for name in validation['checks']]
target = root / 'output/Habbo_Teste78_Base33_Alteracoes.zip'
with tempfile.TemporaryDirectory(dir=folder) as temp:
    temporary = Path(temp) / 'release.zip'
    with zipfile.ZipFile(temporary, 'w', zipfile.ZIP_DEFLATED, compresslevel=6) as archive:
        for path in files:
            archive.write(root / path, path)
    with zipfile.ZipFile(temporary) as archive:
        assert archive.testzip() is None and archive.namelist() == files
        assert hashlib.sha256(archive.read('work/HabboTablet_Token78_Base33.swf')).hexdigest() == release['swfSha256']
    os.replace(temporary, target)
target.chmod(0o644)
(root / 'output/Habbo_2.32.43_Teste78_Base33.apk').chmod(0o644)
print(f'PASS: {len(files)} changed files in {target.name}')
