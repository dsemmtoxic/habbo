#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p work/feature74 work/classes
classpath=.task-tools/ffdec/ffdec.jar:work/classes
target=work/HabboTablet_Token74_Base33.swf
java -XX:-UsePerfData -m jdk.compiler/com.sun.tools.javac.Main -sourcepath work -cp "$classpath" -d work/classes work/PatchToken74.java >work/feature74/compile.log 2>&1
java -XX:-UsePerfData -Xmx1g -cp "$classpath" PatchToken71 work/HabboTablet_LoginSSO33.swf "$target" >work/feature74/build.log 2>&1
rg -q '^PASS: Teste71' work/feature74/build.log
java -XX:-UsePerfData -Xmx768m -cp "$classpath" PatchToken72 "$target" >>work/feature74/build.log 2>&1
rg -q '^PASS: Teste72' work/feature74/build.log
java -XX:-UsePerfData -Xmx768m -cp "$classpath" PatchToken73 "$target" >>work/feature74/build.log 2>&1
rg -q '^PASS: Teste73' work/feature74/build.log
java -XX:-UsePerfData -Xmx768m -cp "$classpath" PatchToken74 "$target" >>work/feature74/build.log 2>&1
rg -q '^PASS: Teste74' work/feature74/build.log
