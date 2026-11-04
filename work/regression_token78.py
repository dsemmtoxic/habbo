"""Check the scope of the patch and exercise the saved peer-to-wire path."""
from pathlib import Path
import hashlib
import json
import subprocess

root = Path(__file__).resolve().parents[1]
folder = root / 'work/feature78'
base = 'work/HabboTablet_Token77_Base33.swf'
target = 'work/HabboTablet_Token78_Base33.swf'
classpath = '.task-tools/ffdec/ffdec.jar:work/classes'
subprocess.run(['java', '-XX:-UsePerfData', '-m', 'jdk.compiler/com.sun.tools.javac.Main',
                '-sourcepath', 'work', '-cp', classpath, '-d', 'work/classes',
                'work/VerifyToken78.java', 'work/AuditToken78.java'], cwd=root, check=True)

checks = []
for name, main, args in [('avatar-wire', 'VerifyToken78', [target]),
                         ('audit', 'AuditToken78', [base, target]),
                         ('asset-performance', 'VerifyToken76', [target]),
                         ('native-retained', 'VerifyRetained33', [target])]:
    log = folder / ('test-' + name + '.log')
    with log.open('w') as out:
        subprocess.run(['java', '-XX:-UsePerfData', '-Xmx768m', '-cp', classpath, main, *args],
                       cwd=root, stdout=out, stderr=subprocess.STDOUT, check=True)
    assert b'PASS:' in log.read_bytes()
    checks.append(name)
report = {'checkpoint': 78, 'checks': checks,
          'swfSha256': hashlib.sha256((root / target).read_bytes()).hexdigest(),
          'physicalAndroidTested': False, 'liveHotelTested': False}
(folder / 'validation78.json').write_text(json.dumps(report, indent=2) + '\n')
