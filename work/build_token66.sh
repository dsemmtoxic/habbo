#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p work/feature66 work/classes
java -XX:-UsePerfData -m jdk.compiler/com.sun.tools.javac.Main -sourcepath work -cp .task-tools/ffdec/ffdec.jar -d work/classes work/PatchToken66.java >work/feature66/compile.log 2>&1
java -XX:-UsePerfData -Xmx1g -cp .task-tools/ffdec/ffdec.jar:work/classes PatchToken66 work/HabboTablet_LoginSSO33.swf work/HabboTablet_Token66_Base33.swf >work/feature66/build.log 2>&1
printf 'PASS: token66 startup hotfix built from verified33.\n'
