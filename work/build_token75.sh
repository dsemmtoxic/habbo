#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p work/feature75 work/classes
classpath=.task-tools/ffdec/ffdec.jar:work/classes
java -XX:-UsePerfData -m jdk.compiler/com.sun.tools.javac.Main -sourcepath work -cp "$classpath" -d work/classes work/PatchToken75.java >work/feature75/compile.log 2>&1
java -XX:-UsePerfData -Xmx768m -cp "$classpath" PatchToken75 work/HabboTablet_Token74_Base33.swf work/HabboTablet_Token75_Base33.swf >work/feature75/build.log 2>&1
rg -q '^PASS: Teste75' work/feature75/build.log
