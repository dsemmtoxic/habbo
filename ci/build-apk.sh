#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."

if [[ $# -ne 1 ]]; then
  printf 'Uso: bash ci/build-apk.sh caminho/do/apk-sem-assinatura.apk\n' >&2
  exit 2
fi

bash work/build_token80.sh
python3 work/regression_token80.py
python3 work/make_token_apk80.py --output "$1"
