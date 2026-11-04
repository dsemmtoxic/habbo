#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p work/feature68 work/classes
java -XX:-UsePerfData -m jdk.compiler/com.sun.tools.javac.Main -sourcepath work -cp .task-tools/ffdec/ffdec.jar -d work/classes work/PatchToken68.java >work/feature68/compile.log 2>&1
java -XX:-UsePerfData -Xmx1g -cp .task-tools/ffdec/ffdec.jar:work/classes PatchToken68 work/HabboTablet_LoginSSO33.swf work/HabboTablet_Token68_Base33.swf >work/feature68/build.log 2>&1
printf 'PASS: token68 built from verified33.\n'
