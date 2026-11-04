"""Package active Base33 sources and a checked delta against the Teste72 archive."""
from pathlib import Path
import hashlib
import json
import re
import zipfile

root = Path(__file__).resolve().parents[1]
folder = root / 'work/feature73'
release = json.loads((folder / 'release73.json').read_text())
validation = json.loads((folder / 'validation73.json').read_text())
assert release['checkpoint'] == validation['checkpoint'] == 73
assert release['base'] == validation['base'] == 33
assert release['androidVersionName'] == '2.32.38-t73-b33'
assert release['androidVersionCode'] == 2032172
assert release['signerSha256'] == '35867bcb9b79522df091687a6b2784fa7859dd68121ecb5a452a745735d39aa9'
expected = {'settings', 'navigator', 'lighting', 'retained33', 'startup-types', 'event', 'styles', 'room-history', 'badges', 'dc', 'readers',
            'entrance-sorting', 'audit', 'localization', 'console', 'login', 'mesh',
            'native-2760-class-roundtrip', 'colorBindings', 'logout', 'render', 'market',
            'mask', 'browser-script', 'ping', 'avatars', 'lighting-reference'}
assert len(validation['checks']) == 27 and {r['check'] for r in validation['checks']} == expected
assert validation['swfSha256'] == release['swfSha256']
assert not validation['physicalAndroidTested'] and not validation['liveHotelTested']
apk = root / 'output/Habbo_2.32.38_Teste73_Base33.apk'
assert hashlib.sha256(apk.read_bytes()).hexdigest() == release['sha256']
assert hashlib.sha256((root / 'work/HabboTablet_Token73_Base33.swf').read_bytes()).hexdigest() == release['swfSha256']
for row in validation['checks']:
    data = (root / row['log']).read_bytes()
    assert hashlib.sha256(data).hexdigest() == row['sha256'] and b'PASS:' in data
signature = (folder / 'apk-signature.log').read_text()
assert 'PASS:' in signature and 'Warnings: []' in signature and release['signerSha256'] in signature
assert (root / 'work/PROGRESSO_INTEGRACAO_NATIVA.md').read_text().startswith('# Teste73 / Base33')

new_files = [
    'work/PatchToken73.java', 'work/VerifyToken73.java', 'work/AuditToken73.java',
    'work/HabboTablet_Token73_Base33.swf', 'work/README_TOKEN73.md',
    'work/build_token73.sh', 'work/regression_token73.py', 'work/make_token_apk73.py',
    'work/package_token73.py', 'work/feature73/release73.json',
    'work/feature73/validation73.json', 'work/feature73/method-review73.txt',
    'work/feature73/build.log', 'work/feature73/compile.log',
    'work/feature73/tests-compile.log', 'work/feature73/regression-run.log',
    'work/feature73/apk-build.log', 'work/feature73/apk-signature.log',
    'work/feature73/package-plan73.json',
]
new_files += [row['log'] for row in validation['checks'] if row['log'].startswith('work/feature73/')]
previous = json.loads((root / 'work/feature72/package-plan72.json').read_text())
previous_zip = root / 'output/Habbo_Token72_Base33_Fontes.zip'
assert hashlib.sha256(previous_zip.read_bytes()).hexdigest() == '604f23df36f4e7435751f7d162ba1b4ea80438c9962e1e058b7f43bbcaf028e7'
with zipfile.ZipFile(previous_zip) as archive:
    changed = [name for name in previous['full'] if archive.read(name) != (root / name).read_bytes()]
assert set(changed) == {'work/RoomUse70.as',
                        'work/texts68.json', 'work/PROGRESSO_INTEGRACAO_NATIVA.md'}, changed
plan = {'full': sorted(set(previous['full'] + new_files)), 'delta': sorted(set(changed + new_files)),
        'changedExisting': sorted(changed), 'baseArchive': previous_zip.name}
(folder / 'package-plan73.json').write_text(json.dumps(plan, indent=2) + '\n')
results = []
for kind, filename in [('full', 'Habbo_Token73_Base33_Fontes.zip'),
                       ('delta', 'Habbo_Teste73_Base33_Alteracoes.zip')]:
    records = []
    for name in plan[kind]:
        assert not Path(name).is_absolute() and '..' not in Path(name).parts
        assert not re.search(r'(?:signing-key|signing-cert|Assinatura_Privada|restore73-private|upload/|library-helpers)', name, re.I)
        data = (root / name).read_bytes()
        records.append({'path': name, 'bytes': len(data), 'sha256': hashlib.sha256(data).hexdigest()})
    manifest = {'checkpoint': 73, 'base': 33, 'route': release['route'], 'kind': kind, 'files': records}
    output = root / 'output' / filename
    with zipfile.ZipFile(output, 'w', compression=zipfile.ZIP_DEFLATED, compresslevel=6) as archive:
        for row in records:
            info = zipfile.ZipInfo(row['path'], (2026, 11, 3, 0, 0, 0))
            info.compress_type = zipfile.ZIP_DEFLATED
            info.external_attr = (0o100755 if row['path'].endswith('.sh') else 0o100644) << 16
            archive.writestr(info, (root / row['path']).read_bytes())
        archive.writestr('PACKAGE_MANIFEST_TOKEN73.json', json.dumps(manifest, ensure_ascii=False, indent=2) + '\n')
    with zipfile.ZipFile(output) as archive:
        assert archive.testzip() is None
        assert len(archive.namelist()) == len(set(archive.namelist())) == len(records) + 1
        for row in records:
            assert hashlib.sha256(archive.read(row['path'])).hexdigest() == row['sha256']
    result = {'kind': kind, 'filename': filename, 'bytes': output.stat().st_size,
              'sha256': hashlib.sha256(output.read_bytes()).hexdigest(), 'entries': len(records) + 1}
    results.append(result)
    print('PASS: ' + json.dumps(result), flush=True)
(folder / 'archives73.json').write_text(json.dumps(results, indent=2) + '\n')
