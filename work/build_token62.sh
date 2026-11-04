#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p work/feature62 work/classes
java -XX:-UsePerfData -m jdk.compiler/com.sun.tools.javac.Main -sourcepath work -cp .task-tools/ffdec/ffdec.jar -d work/classes work/PatchToken62.java >work/feature62/compile.log 2>&1
java -XX:-UsePerfData -Xmx768m -cp .task-tools/ffdec/ffdec.jar:work/classes PatchToken62 work/HabboTablet_LoginSSO33.swf work/HabboTablet_Token62_Base33.swf >work/feature62/build.log 2>&1
printf 'PASS: token62 built from verified33.\n'
