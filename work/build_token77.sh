#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p work/feature77 work/classes
classpath=.task-tools/ffdec/ffdec.jar:work/classes
java -XX:-UsePerfData -m jdk.compiler/com.sun.tools.javac.Main -sourcepath work -cp "$classpath" -d work/classes work/PatchToken77.java >work/feature77/compile.log 2>&1
java -XX:-UsePerfData -Xmx768m -cp "$classpath" PatchToken77 work/HabboTablet_Token76_Base33.swf work/HabboTablet_Token77_Base33.swf >work/feature77/build.log 2>&1
rg -q '^PASS: Teste77' work/feature77/build.log
