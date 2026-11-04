#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p work/feature73 work/classes
java -XX:-UsePerfData -m jdk.compiler/com.sun.tools.javac.Main -sourcepath work -cp .task-tools/ffdec/ffdec.jar -d work/classes work/PatchToken73.java >work/feature73/compile.log 2>&1
classpath=.task-tools/ffdec/ffdec.jar:work/classes
target=work/HabboTablet_Token73_Base33.swf
java -XX:-UsePerfData -Xmx1g -cp "$classpath" PatchToken72 work/HabboTablet_LoginSSO33.swf "$target" >work/feature73/build.log 2>&1
rg -q '^PASS: Teste72' work/feature73/build.log
java -XX:-UsePerfData -Xmx768m -cp "$classpath" PatchToken73 "$target" >>work/feature73/build.log 2>&1
rg -q '^PASS: Teste73' work/feature73/build.log
printf 'PASS: token73 built from verified33.\n'
