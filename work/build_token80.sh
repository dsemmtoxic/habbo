#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p work/feature80 work/classes
classpath=.task-tools/ffdec/ffdec.jar:work/classes
java -XX:-UsePerfData -m jdk.compiler/com.sun.tools.javac.Main -sourcepath work -cp "$classpath" -d work/classes work/PatchToken80.java >work/feature80/compile.log 2>&1
java -XX:-UsePerfData -Xmx768m -cp "$classpath" PatchToken80 work/HabboTablet_Token79_Base33.swf work/HabboTablet_Token80_Base33.swf >work/feature80/build.log 2>&1
grep -q '^PASS:' work/feature80/build.log
