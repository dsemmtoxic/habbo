"""Create reproducible handoff archives from a strict active-branch allowlist."""
from pathlib import Path
import hashlib, json, re, zipfile
ROOT = Path(__file__).resolve().parents[1]
plan = json.loads((ROOT / 'work/feature63/package-plan63.json').read_text())
outputs = {'full': 'Habbo_Token63_Base33_Fontes.zip', 'delta': 'Habbo_Teste63_Base33_Alteracoes.zip'}
results = []
for kind, filename in outputs.items():
    paths = plan[kind]
    assert paths == sorted(set(paths))
    records = []
    for name in paths:
        relative = Path(name)
        assert not relative.is_absolute() and '..' not in relative.parts
        assert not re.search(r'(?:signing-key|signing-cert|Assinatura_Privada|NativeAir|AuthSession34)', name, re.I)
        target = ROOT / relative
        assert target.is_file(), name
        data = target.read_bytes()
        records.append({'path': name, 'bytes': len(data), 'sha256': hashlib.sha256(data).hexdigest()})
    manifest = json.dumps({'checkpoint': 63, 'base': 33, 'route': 'token only', 'kind': kind, 'files': records}, ensure_ascii=False, indent=2).encode() + b'\n'
    output = ROOT / 'output' / filename
    output.parent.mkdir(exist_ok=True)
    with zipfile.ZipFile(output, 'w', compression=zipfile.ZIP_DEFLATED, compresslevel=6) as archive:
        for row in records:
            info = zipfile.ZipInfo(row['path'], (2026, 11, 2, 0, 0, 0))
            info.compress_type = zipfile.ZIP_DEFLATED
            info.external_attr = (0o100755 if row['path'].endswith('.sh') else 0o100644) << 16
            archive.writestr(info, (ROOT / row['path']).read_bytes())
        archive.writestr('PACKAGE_MANIFEST_TOKEN63.json', manifest)
    with zipfile.ZipFile(output) as archive:
        assert archive.testzip() is None
        assert len(archive.namelist()) == len(set(archive.namelist())) == len(records) + 1
        for row in records:
            data = archive.read(row['path'])
            assert len(data) == row['bytes'] and hashlib.sha256(data).hexdigest() == row['sha256']
    result = {'kind': kind, 'filename': filename, 'bytes': output.stat().st_size, 'sha256': hashlib.sha256(output.read_bytes()).hexdigest(), 'entries': len(records) + 1}
    results.append(result)
    print('PASS: ' + json.dumps(result), flush=True)
(ROOT / 'work/feature63/archives63.json').write_text(json.dumps(results, indent=2) + '\n')
