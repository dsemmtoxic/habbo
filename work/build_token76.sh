#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p work/feature76 work/classes
classpath=.task-tools/ffdec/ffdec.jar:work/classes
java -XX:-UsePerfData -m jdk.compiler/com.sun.tools.javac.Main -sourcepath work -cp "$classpath" -d work/classes work/PatchToken76.java >work/feature76/compile.log 2>&1
java -XX:-UsePerfData -Xmx768m -cp "$classpath" PatchToken76 work/HabboTablet_Token75_Base33.swf work/HabboTablet_Token76_Base33.swf >work/feature76/build.log 2>&1
rg -q '^PASS: Teste76' work/feature76/build.log
