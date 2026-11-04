#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p work/feature78 work/classes
classpath=.task-tools/ffdec/ffdec.jar:work/classes
java -XX:-UsePerfData -m jdk.compiler/com.sun.tools.javac.Main -sourcepath work -cp "$classpath" -d work/classes work/PatchToken78.java >work/feature78/compile.log 2>&1
java -XX:-UsePerfData -Xmx768m -cp "$classpath" PatchToken78 work/HabboTablet_Token77_Base33.swf work/HabboTablet_Token78_Base33.swf >work/feature78/build.log 2>&1
rg -q '^PASS:' work/feature78/build.log
