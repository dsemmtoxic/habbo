"""Execute saved AVM2 and browser script; Android/GPU/live hotel are boundaries."""
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor, as_completed
import hashlib
import json
import subprocess
import shutil
import sys

root = Path(__file__).resolve().parents[1]
folder = root / 'work/feature76'
folder.mkdir(exist_ok=True)
sources = (root / 'work/feature63/java-sources.txt').read_text().splitlines() + [
    'PatchToken64.java', 'VerifyToken64.java', 'PatchToken65.java', 'VerifyToken65.java', 'AuditToken65.java',
    'PatchToken66.java', 'VerifyToken66.java', 'AuditToken66.java',
    'PatchToken67.java', 'VerifyToken67.java', 'AuditToken67.java',
    'PatchToken68.java', 'VerifyToken68.java', 'AuditToken68.java',
    'PatchToken69.java', 'VerifyToken69.java', 'AuditToken69.java',
    'PatchToken70.java', 'VerifyToken70.java', 'AuditToken70.java',
    'PatchToken71.java', 'VerifyToken71.java', 'AuditToken71.java',
    'PatchToken72.java', 'VerifyToken72.java', 'AuditToken72.java',
    'PatchToken73.java', 'VerifyToken73.java', 'AuditToken73.java',
    'PatchToken74.java', 'VerifyToken74.java', 'AuditToken74.java',
    'PatchToken75.java', 'VerifyToken75.java', 'AuditToken75.java',
    'PatchToken76.java', 'VerifyToken76.java', 'AuditToken76.java',
]
with (folder / 'tests-compile.log').open('w') as log:
    subprocess.run(['java', '-XX:-UsePerfData', '-m', 'jdk.compiler/com.sun.tools.javac.Main',
                    '-cp', '.task-tools/ffdec/ffdec.jar', '-d', 'work/classes'] +
                   ['work/' + name for name in sources], cwd=root, stdout=log, stderr=subprocess.STDOUT, check=True)
commands = []
def java(label, cls, args):
    commands.append((label, ['java', '-XX:-UsePerfData', '-Xmx768m', '-cp',
                            '.task-tools/ffdec/ffdec.jar:work/classes', cls] + args))
target = 'work/HabboTablet_Token76_Base33.swf'
previous = 'work/HabboTablet_Token70_Base33.swf'
for mode in ['settings', 'render']:
    java(mode, 'VerifyToken64', ['work/HabboTablet_Token63_Base33.swf', target, mode])
for mode in ['lighting', 'mesh']:
    java(mode, 'VerifyToken65', [target, mode])
for mode in ['logout', 'entrance', 'console']:
    java('entrance-sorting' if mode == 'entrance' else mode, 'VerifyToken67',
         ['work/HabboTablet_Token66_Base33.swf', target, mode])
for mode in ['localization', 'login', 'navigator', 'mask']:
    java(mode, 'VerifyToken68', [target, mode])
for mode in ['market', 'ping', 'avatars', 'lighting-reference']:
    java(mode, 'VerifyToken69', [target, mode])
for mode in ['styles', 'room-history', 'event', 'badges']:
    java(mode, 'VerifyToken70', [target, mode])
java('dc', 'VerifyToken71', [previous, 'work/HabboTablet_Token72_Base33.swf', 'dc'])
reference = 'work/HabboTablet_Token72_Base33.swf'
java('readers', 'VerifyToken73', [reference, target])
java('explicit-readers', 'VerifyToken74', [target])
java('audit', 'AuditToken76', ['work/HabboTablet_Token75_Base33.swf', target])
java('asset-priority', 'VerifyToken75', ['work/HabboTablet_Token75_Base33.swf'])
java('asset-performance', 'VerifyToken76', [target])
java('retained33', 'VerifyRetained33', [target])
java('colorBindings', 'VerifyColorBindings61', [target])
java('startup-types', 'VerifyToken66', ['work/HabboTablet_Token65_Base33.swf', target])
commands.append(('browser-script', [shutil.which('node') or 'node', 'work/test_session67.js']))
def run(item):
    label, args = item
    path = folder / ('test-' + label + '.log')
    with path.open('w') as log:
        subprocess.run(args, cwd=root, stdout=log, stderr=subprocess.STDOUT, check=True)
    data = path.read_bytes()
    assert b'PASS:' in data and b'Exception in thread' not in data
    return {'check': label, 'log': path.relative_to(root).as_posix(), 'sha256': hashlib.sha256(data).hexdigest()}
records = []
with ThreadPoolExecutor(max_workers=3) as pool:
    for result in as_completed([pool.submit(run, item) for item in commands]):
        record = result.result()
        records.append(record)
        print('PASS ' + record['check'], flush=True)
native = root / 'work/feature65/native-validation65.json'
dex = root / 'work/feature65/classes65.dex'
if not native.exists() or not dex.exists():
    subprocess.run([sys.executable, 'work/build_native65.py'], cwd=root, check=True)
    subprocess.run([sys.executable, 'work/check_native65.py'], cwd=root, check=True)
native_result = json.loads(native.read_text())
assert native_result['sha256'] == hashlib.sha256(dex.read_bytes()).hexdigest()
native_log = root / 'work/feature65/test-native.log'
records.append({'check': 'native-2760-class-roundtrip', 'log': 'work/feature65/test-native.log',
                'sha256': hashlib.sha256(native_log.read_bytes()).hexdigest()})
assert len(records) == 30
assert hashlib.sha256((root / 'work/HabboTablet_LoginSSO33.swf').read_bytes()).hexdigest() == 'de8dd00c53bd9ece24563558ce7a19ad6183e94bad2ec651c06fd20f46d3e901'
report = {'checkpoint': 76, 'base': 33, 'route': 'official-site browser session or manual launcher token',
          'checks': sorted(records, key=lambda row: row['check']),
          'swfSha256': hashlib.sha256((root / target).read_bytes()).hexdigest(),
          'nativeDexSha256': native_result['sha256'], 'physicalAndroidTested': False, 'liveHotelTested': False,
          'boundaries': ['Android/GPU/stencil rasterization', 'Feathers font/layout measurement',
                         'operating-system event delivery', 'live hotel transactions, badge inventory/save, latency and Wired user-click execution',
                         'real signed-in browser session and cookie persistence']}
(folder / 'validation76.json').write_text(json.dumps(report, indent=2) + '\n')
print('PASS: 30 focused/regression checks; physical Android and live hotel validation remain pending.', flush=True)
