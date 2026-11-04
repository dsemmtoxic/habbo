"""Package active Base33 sources and a checked delta against the Teste74 archive."""
from pathlib import Path
import hashlib
import json
import re
import zipfile

root = Path(__file__).resolve().parents[1]
folder = root / 'work/feature75'
release = json.loads((folder / 'release75.json').read_text())
validation = json.loads((folder / 'validation75.json').read_text())
assert release['checkpoint'] == validation['checkpoint'] == 75
assert release['base'] == validation['base'] == 33
assert release['androidVersionName'] == '2.32.40-t75-b33'
assert release['androidVersionCode'] == 2032174
assert release['signerSha256'] == '35867bcb9b79522df091687a6b2784fa7859dd68121ecb5a452a745735d39aa9'
expected = {'asset-priority', 'settings', 'navigator', 'lighting', 'retained33', 'startup-types', 'event', 'styles', 'room-history', 'badges', 'dc', 'readers', 'explicit-readers',
            'entrance-sorting', 'audit', 'localization', 'console', 'login', 'mesh',
            'native-2760-class-roundtrip', 'colorBindings', 'logout', 'render', 'market',
            'mask', 'browser-script', 'ping', 'avatars', 'lighting-reference'}
assert len(validation['checks']) == 29 and {r['check'] for r in validation['checks']} == expected
assert validation['swfSha256'] == release['swfSha256']
assert not validation['physicalAndroidTested'] and not validation['liveHotelTested']
apk = root / 'output/Habbo_2.32.40_Teste75_Base33.apk'
assert hashlib.sha256(apk.read_bytes()).hexdigest() == release['sha256']
assert hashlib.sha256((root / 'work/HabboTablet_Token75_Base33.swf').read_bytes()).hexdigest() == release['swfSha256']
for row in validation['checks']:
    data = (root / row['log']).read_bytes()
    assert hashlib.sha256(data).hexdigest() == row['sha256'] and b'PASS:' in data
signature = (folder / 'apk-signature.log').read_text()
assert 'PASS:' in signature and 'Warnings: []' in signature and release['signerSha256'] in signature
assert (root / 'work/PROGRESSO_INTEGRACAO_NATIVA.md').read_text().startswith('# Teste75 / Base33')

new_files = [
    'work/RoomAssetQueue75.as',
    'work/PatchToken75.java', 'work/VerifyToken75.java', 'work/AuditToken75.java',
    'work/HabboTablet_Token75_Base33.swf', 'work/README_TOKEN75.md',
    'work/build_token75.sh', 'work/regression_token75.py', 'work/make_token_apk75.py',
    'work/package_token75.py', 'work/feature75/release75.json',
    'work/feature75/validation75.json',
    'work/feature75/build.log', 'work/feature75/compile.log',
    'work/feature75/tests-compile.log', 'work/feature75/regression-run.log',
    'work/feature75/apk-build.log', 'work/feature75/apk-signature.log',
    'work/feature75/package-plan75.json',
]
new_files += [row['log'] for row in validation['checks'] if row['log'].startswith('work/feature75/')]
previous = json.loads((root / 'work/feature74/package-plan74.json').read_text())
previous_zip = root.parent / 'recovered/Habbo_Token74_Base33_Fontes.zip'
assert hashlib.sha256(previous_zip.read_bytes()).hexdigest() == '88c89acbdef8c5058686f878fde0f3054868be74a0b7e7f1654c15496e3fd3e5'
with zipfile.ZipFile(previous_zip) as archive:
    changed = [name for name in previous['full'] if archive.read(name) != (root / name).read_bytes()]
assert set(changed) == {'work/PROGRESSO_INTEGRACAO_NATIVA.md'}, changed
plan = {'full': sorted(set(previous['full'] + new_files)), 'delta': sorted(set(changed + new_files)),
        'changedExisting': sorted(changed), 'baseArchive': previous_zip.name}
(folder / 'package-plan75.json').write_text(json.dumps(plan, indent=2) + '\n')
results = []
for kind, filename in [('full', 'Habbo_Token75_Base33_Fontes.zip'),
                       ('delta', 'Habbo_Teste75_Base33_Alteracoes.zip')]:
    records = []
    for name in plan[kind]:
        assert not Path(name).is_absolute() and '..' not in Path(name).parts
        assert not re.search(r'(?:signing-key|signing-cert|Assinatura_Privada|restore74-private|upload/|library-helpers)', name, re.I)
        data = (root / name).read_bytes()
        records.append({'path': name, 'bytes': len(data), 'sha256': hashlib.sha256(data).hexdigest()})
    manifest = {'checkpoint': 75, 'base': 33, 'route': release['route'], 'kind': kind, 'files': records}
    output = root / 'output' / filename
    with zipfile.ZipFile(output, 'w', compression=zipfile.ZIP_DEFLATED, compresslevel=6) as archive:
        for row in records:
            info = zipfile.ZipInfo(row['path'], (2026, 11, 3, 0, 0, 0))
            info.compress_type = zipfile.ZIP_DEFLATED
            info.external_attr = (0o100755 if row['path'].endswith('.sh') else 0o100644) << 16
            archive.writestr(info, (root / row['path']).read_bytes())
        archive.writestr('PACKAGE_MANIFEST_TOKEN75.json', json.dumps(manifest, ensure_ascii=False, indent=2) + '\n')
    with zipfile.ZipFile(output) as archive:
        assert archive.testzip() is None
        assert len(archive.namelist()) == len(set(archive.namelist())) == len(records) + 1
        for row in records:
            assert hashlib.sha256(archive.read(row['path'])).hexdigest() == row['sha256']
    result = {'kind': kind, 'filename': filename, 'bytes': output.stat().st_size,
              'sha256': hashlib.sha256(output.read_bytes()).hexdigest(), 'entries': len(records) + 1}
    results.append(result)
    print('PASS: ' + json.dumps(result), flush=True)
(folder / 'archives75.json').write_text(json.dumps(results, indent=2) + '\n')
