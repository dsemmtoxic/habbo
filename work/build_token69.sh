#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p work/feature69 work/classes
java -XX:-UsePerfData -m jdk.compiler/com.sun.tools.javac.Main -sourcepath work -cp .task-tools/ffdec/ffdec.jar -d work/classes work/PatchToken69.java >work/feature69/compile.log 2>&1
java -XX:-UsePerfData -Xmx1g -cp .task-tools/ffdec/ffdec.jar:work/classes PatchToken69 work/HabboTablet_LoginSSO33.swf work/HabboTablet_Token69_Base33.swf >work/feature69/build.log 2>&1
printf 'PASS: token69 built from verified33.\n'
