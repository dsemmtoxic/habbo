#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p work/feature67 work/classes
java -XX:-UsePerfData -m jdk.compiler/com.sun.tools.javac.Main -sourcepath work -cp .task-tools/ffdec/ffdec.jar -d work/classes work/PatchToken67.java >work/feature67/compile.log 2>&1
java -XX:-UsePerfData -Xmx1g -cp .task-tools/ffdec/ffdec.jar:work/classes PatchToken67 work/HabboTablet_LoginSSO33.swf work/HabboTablet_Token67_Base33.swf >work/feature67/build.log 2>&1
printf 'PASS: token67 built from verified33.\n'
