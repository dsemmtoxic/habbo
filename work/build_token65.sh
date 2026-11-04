#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p work/feature65 work/classes
java -XX:-UsePerfData -m jdk.compiler/com.sun.tools.javac.Main -sourcepath work -cp .task-tools/ffdec/ffdec.jar -d work/classes work/PatchToken65.java >work/feature65/compile.log 2>&1
java -XX:-UsePerfData -Xmx1g -cp .task-tools/ffdec/ffdec.jar:work/classes PatchToken65 work/HabboTablet_LoginSSO33.swf work/HabboTablet_Token65_Base33.swf >work/feature65/build.log 2>&1
printf 'PASS: token65 built from verified33.\n'
