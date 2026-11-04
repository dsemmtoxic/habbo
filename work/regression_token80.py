"""Exercise the saved Builder Club, avatar preference, and retained client paths."""
from pathlib import Path
import hashlib
import json
import subprocess

root = Path(__file__).resolve().parents[1]
folder = root / 'work/feature80'
base = 'work/HabboTablet_Token78_Base33.swf'
target = 'work/HabboTablet_Token80_Base33.swf'
classpath = '.task-tools/ffdec/ffdec.jar:work/classes'
subprocess.run(['java', '-XX:-UsePerfData', '-m', 'jdk.compiler/com.sun.tools.javac.Main',
                '-sourcepath', 'work', '-cp', classpath, '-d', 'work/classes',
                'work/VerifyToken80.java', 'work/VerifyToken79.java',
                'work/VerifyToken76.java', 'work/VerifyRetained33.java'], cwd=root, check=True)

checks = []
for name, main, args in [('avatar-wire', 'VerifyToken79', [base, target]),
                         ('builder-and-menu', 'VerifyToken80', [target]),
                         ('asset-performance', 'VerifyToken76', [target]),
                         ('native-retained', 'VerifyRetained33', [target])]:
    log = folder / ('test-' + name + '.log')
    with log.open('w') as out:
        subprocess.run(['java', '-XX:-UsePerfData', '-Xmx768m', '-cp', classpath, main, *args],
                       cwd=root, stdout=out, stderr=subprocess.STDOUT, check=True)
    assert b'PASS:' in log.read_bytes()
    checks.append(name)
report = {'checkpoint': 80, 'checks': checks,
          'swfSha256': hashlib.sha256((root / target).read_bytes()).hexdigest(),
          'physicalAndroidTested': False, 'liveHotelTested': False}
(folder / 'validation80.json').write_text(json.dumps(report, indent=2) + '\n')
