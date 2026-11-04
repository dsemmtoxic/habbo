"""Package active Base33 sources and a checked delta against the Teste76 archive."""
from pathlib import Path
import hashlib
import json
import re
import zipfile

root = Path(__file__).resolve().parents[1]
folder = root / 'work/feature77'
release = json.loads((folder / 'release77.json').read_text())
validation = json.loads((folder / 'validation77.json').read_text())
assert release['checkpoint'] == validation['checkpoint'] == 77
assert release['base'] == validation['base'] == 33
assert release['androidVersionName'] == '2.32.42-t77-b33'
assert release['androidVersionCode'] == 2032176
assert release['signerSha256'] == '35867bcb9b79522df091687a6b2784fa7859dd68121ecb5a452a745735d39aa9'
expected = {'asset-priority', 'asset-performance', 'settings', 'navigator', 'lighting', 'retained33', 'startup-types', 'event', 'styles', 'room-history', 'badges', 'dc', 'readers', 'explicit-readers',
            'entrance-sorting', 'audit', 'localization', 'console', 'login', 'mesh',
            'native-2760-class-roundtrip', 'colorBindings', 'logout', 'render', 'market',
            'mask', 'browser-script', 'ping', 'avatars', 'lighting-reference'}
assert len(validation['checks']) == 30 and {r['check'] for r in validation['checks']} == expected
assert validation['swfSha256'] == release['swfSha256']
assert not validation['physicalAndroidTested'] and not validation['liveHotelTested']
apk = root / 'output/Habbo_2.32.42_Teste77_Base33.apk'
assert hashlib.sha256(apk.read_bytes()).hexdigest() == release['sha256']
assert hashlib.sha256((root / 'work/HabboTablet_Token77_Base33.swf').read_bytes()).hexdigest() == release['swfSha256']
for row in validation['checks']:
    data = (root / row['log']).read_bytes()
    assert hashlib.sha256(data).hexdigest() == row['sha256'] and b'PASS:' in data
signature = (folder / 'apk-signature.log').read_text()
assert 'PASS:' in signature and 'Warnings: []' in signature and release['signerSha256'] in signature
assert (root / 'work/PROGRESSO_INTEGRACAO_NATIVA.md').read_text().startswith('# Teste77 / Base33')

new_files = [
    'work/Avatar77.as',
    'work/PatchToken77.java', 'work/VerifyToken77.java', 'work/AuditToken77.java',
    'work/HabboTablet_Token77_Base33.swf', 'work/README_TOKEN77.md',
    'work/build_token77.sh', 'work/regression_token77.py', 'work/make_token_apk77.py',
    'work/package_token77.py', 'work/feature77/release77.json',
    'work/feature77/validation77.json',
    'work/feature77/build.log', 'work/feature77/compile.log',
    'work/feature77/tests-compile.log', 'work/feature77/regression-run.log',
    'work/feature77/apk-build.log', 'work/feature77/apk-signature.log',
    'work/feature77/package-plan77.json',
]
new_files += [row['log'] for row in validation['checks'] if row['log'].startswith('work/feature77/')]
previous = json.loads((root / 'work/feature76/package-plan76.json').read_text())
previous_zip = root / 'output/Habbo_Token76_Base33_Fontes.zip'
assert hashlib.sha256(previous_zip.read_bytes()).hexdigest() == '568c371bb7d61ee36e19d310f229a3760e26cf9a44e93d29e2ad75975b1cd190'
with zipfile.ZipFile(previous_zip) as archive:
    changed = [name for name in previous['full'] if archive.read(name) != (root / name).read_bytes()]
assert set(changed) == {'work/PROGRESSO_INTEGRACAO_NATIVA.md'}, changed
plan = {'full': sorted(set(previous['full'] + new_files)), 'delta': sorted(set(changed + new_files)),
        'changedExisting': sorted(changed), 'baseArchive': previous_zip.name}
(folder / 'package-plan77.json').write_text(json.dumps(plan, indent=2) + '\n')
results = []
for kind, filename in [('full', 'Habbo_Token77_Base33_Fontes.zip'),
                       ('delta', 'Habbo_Teste77_Base33_Alteracoes.zip')]:
    records = []
    for name in plan[kind]:
        assert not Path(name).is_absolute() and '..' not in Path(name).parts
        assert not re.search(r'(?:signing-key|signing-cert|Assinatura_Privada|restore74-private|upload/|library-helpers)', name, re.I)
        data = (root / name).read_bytes()
        records.append({'path': name, 'bytes': len(data), 'sha256': hashlib.sha256(data).hexdigest()})
    manifest = {'checkpoint': 77, 'base': 33, 'route': release['route'], 'kind': kind, 'files': records}
    output = root / 'output' / filename
    with zipfile.ZipFile(output, 'w', compression=zipfile.ZIP_DEFLATED, compresslevel=6) as archive:
        for row in records:
            info = zipfile.ZipInfo(row['path'], (2026, 11, 3, 0, 0, 0))
            info.compress_type = zipfile.ZIP_DEFLATED
            info.external_attr = (0o100755 if row['path'].endswith('.sh') else 0o100644) << 16
            archive.writestr(info, (root / row['path']).read_bytes())
        archive.writestr('PACKAGE_MANIFEST_TOKEN77.json', json.dumps(manifest, ensure_ascii=False, indent=2) + '\n')
    with zipfile.ZipFile(output) as archive:
        assert archive.testzip() is None
        assert len(archive.namelist()) == len(set(archive.namelist())) == len(records) + 1
        for row in records:
            assert hashlib.sha256(archive.read(row['path'])).hexdigest() == row['sha256']
    result = {'kind': kind, 'filename': filename, 'bytes': output.stat().st_size,
              'sha256': hashlib.sha256(output.read_bytes()).hexdigest(), 'entries': len(records) + 1}
    results.append(result)
    print('PASS: ' + json.dumps(result), flush=True)
(folder / 'archives77.json').write_text(json.dumps(results, indent=2) + '\n')
