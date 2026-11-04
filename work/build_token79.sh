#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p work/feature79 work/classes
classpath=.task-tools/ffdec/ffdec.jar:work/classes
java -XX:-UsePerfData -m jdk.compiler/com.sun.tools.javac.Main -sourcepath work -cp "$classpath" -d work/classes work/PatchToken79.java >work/feature79/compile.log 2>&1
java -XX:-UsePerfData -Xmx768m -cp "$classpath" PatchToken79 work/HabboTablet_Token78_Base33.swf work/HabboTablet_Token79_Base33.swf >work/feature79/build.log 2>&1
rg -q '^PASS:' work/feature79/build.log
