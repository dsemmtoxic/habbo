"""Package active Base33 sources and a checked delta against the Teste75 archive."""
from pathlib import Path
import hashlib
import json
import re
import zipfile

root = Path(__file__).resolve().parents[1]
folder = root / 'work/feature76'
release = json.loads((folder / 'release76.json').read_text())
validation = json.loads((folder / 'validation76.json').read_text())
assert release['checkpoint'] == validation['checkpoint'] == 76
assert release['base'] == validation['base'] == 33
assert release['androidVersionName'] == '2.32.41-t76-b33'
assert release['androidVersionCode'] == 2032175
assert release['signerSha256'] == '35867bcb9b79522df091687a6b2784fa7859dd68121ecb5a452a745735d39aa9'
expected = {'asset-priority', 'asset-performance', 'settings', 'navigator', 'lighting', 'retained33', 'startup-types', 'event', 'styles', 'room-history', 'badges', 'dc', 'readers', 'explicit-readers',
            'entrance-sorting', 'audit', 'localization', 'console', 'login', 'mesh',
            'native-2760-class-roundtrip', 'colorBindings', 'logout', 'render', 'market',
            'mask', 'browser-script', 'ping', 'avatars', 'lighting-reference'}
assert len(validation['checks']) == 30 and {r['check'] for r in validation['checks']} == expected
assert validation['swfSha256'] == release['swfSha256']
assert not validation['physicalAndroidTested'] and not validation['liveHotelTested']
apk = root / 'output/Habbo_2.32.41_Teste76_Base33.apk'
assert hashlib.sha256(apk.read_bytes()).hexdigest() == release['sha256']
assert hashlib.sha256((root / 'work/HabboTablet_Token76_Base33.swf').read_bytes()).hexdigest() == release['swfSha256']
for row in validation['checks']:
    data = (root / row['log']).read_bytes()
    assert hashlib.sha256(data).hexdigest() == row['sha256'] and b'PASS:' in data
signature = (folder / 'apk-signature.log').read_text()
assert 'PASS:' in signature and 'Warnings: []' in signature and release['signerSha256'] in signature
assert (root / 'work/PROGRESSO_INTEGRACAO_NATIVA.md').read_text().startswith('# Teste76 / Base33')

new_files = [
    'work/AssetCache76.as',
    'work/PatchToken76.java', 'work/VerifyToken76.java', 'work/AuditToken76.java',
    'work/HabboTablet_Token76_Base33.swf', 'work/README_TOKEN76.md',
    'work/build_token76.sh', 'work/regression_token76.py', 'work/make_token_apk76.py',
    'work/package_token76.py', 'work/feature76/release76.json',
    'work/feature76/validation76.json',
    'work/feature76/build.log', 'work/feature76/compile.log',
    'work/feature76/tests-compile.log', 'work/feature76/regression-run.log',
    'work/feature76/apk-build.log', 'work/feature76/apk-signature.log',
    'work/feature76/package-plan76.json',
]
new_files += [row['log'] for row in validation['checks'] if row['log'].startswith('work/feature76/')]
previous = json.loads((root / 'work/feature75/package-plan75.json').read_text())
previous_zip = root / 'output/Habbo_Token75_Base33_Fontes.zip'
assert hashlib.sha256(previous_zip.read_bytes()).hexdigest() == 'd2a490704b5146223a24152c58ef7718d078f2a7469b899f3718cb1a86c42bdd'
with zipfile.ZipFile(previous_zip) as archive:
    changed = [name for name in previous['full'] if archive.read(name) != (root / name).read_bytes()]
assert set(changed) == {'work/PROGRESSO_INTEGRACAO_NATIVA.md'}, changed
plan = {'full': sorted(set(previous['full'] + new_files)), 'delta': sorted(set(changed + new_files)),
        'changedExisting': sorted(changed), 'baseArchive': previous_zip.name}
(folder / 'package-plan76.json').write_text(json.dumps(plan, indent=2) + '\n')
results = []
for kind, filename in [('full', 'Habbo_Token76_Base33_Fontes.zip'),
                       ('delta', 'Habbo_Teste76_Base33_Alteracoes.zip')]:
    records = []
    for name in plan[kind]:
        assert not Path(name).is_absolute() and '..' not in Path(name).parts
        assert not re.search(r'(?:signing-key|signing-cert|Assinatura_Privada|restore74-private|upload/|library-helpers)', name, re.I)
        data = (root / name).read_bytes()
        records.append({'path': name, 'bytes': len(data), 'sha256': hashlib.sha256(data).hexdigest()})
    manifest = {'checkpoint': 76, 'base': 33, 'route': release['route'], 'kind': kind, 'files': records}
    output = root / 'output' / filename
    with zipfile.ZipFile(output, 'w', compression=zipfile.ZIP_DEFLATED, compresslevel=6) as archive:
        for row in records:
            info = zipfile.ZipInfo(row['path'], (2026, 11, 3, 0, 0, 0))
            info.compress_type = zipfile.ZIP_DEFLATED
            info.external_attr = (0o100755 if row['path'].endswith('.sh') else 0o100644) << 16
            archive.writestr(info, (root / row['path']).read_bytes())
        archive.writestr('PACKAGE_MANIFEST_TOKEN76.json', json.dumps(manifest, ensure_ascii=False, indent=2) + '\n')
    with zipfile.ZipFile(output) as archive:
        assert archive.testzip() is None
        assert len(archive.namelist()) == len(set(archive.namelist())) == len(records) + 1
        for row in records:
            assert hashlib.sha256(archive.read(row['path'])).hexdigest() == row['sha256']
    result = {'kind': kind, 'filename': filename, 'bytes': output.stat().st_size,
              'sha256': hashlib.sha256(output.read_bytes()).hexdigest(), 'entries': len(records) + 1}
    results.append(result)
    print('PASS: ' + json.dumps(result), flush=True)
(folder / 'archives76.json').write_text(json.dumps(results, indent=2) + '\n')
