#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."

mkdir -p .task-tools
download=$(mktemp -d .task-tools/ffdec-download.XXXXXXXX)
trap 'rm -rf "$download"' EXIT
curl --fail --silent --show-error --location --retry 3 \
  https://github.com/jindrapetrik/jpexs-decompiler/releases/download/version26.4.0/ffdec_26.4.0.zip \
  --output "$download/ffdec.zip"
printf '%s  %s\n' '56ce960aeafc7caf034e2052ba49f878a883f7c7ca690da6eeffca9587b5e4b9' "$download/ffdec.zip" | sha256sum --check
unzip -oq "$download/ffdec.zip" -d .task-tools/ffdec
