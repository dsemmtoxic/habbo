#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."

if [[ $# -ne 2 ]]; then
  printf 'Uso: bash ci/sign-apk.sh apk-sem-assinatura.apk apk-assinado.apk\n' >&2
  exit 2
fi
for secret in KEYSTORE_BASE64 KEYSTORE_PASSWORD KEY_ALIAS KEY_PASSWORD; do
  if [[ -z ${!secret:-} ]]; then
    printf 'Secret obrigatório: %s\n' "$secret" >&2
    exit 1
  fi
done

if [[ -z ${ANDROID_BUILD_TOOLS:-} ]]; then
  : "${ANDROID_HOME:?Defina ANDROID_HOME ou ANDROID_BUILD_TOOLS}"
  ANDROID_BUILD_TOOLS="$ANDROID_HOME/build-tools/36.0.0"
fi
zipalign="$ANDROID_BUILD_TOOLS/zipalign"
apksigner="$ANDROID_BUILD_TOOLS/apksigner"

expected_signer=$(python3 -c 'import json; print(json.load(open("inputs/base_token33.json"))["signerSha256"])')
unsigned=$1
destination=$2
mkdir -p -- "$(dirname -- "$destination")"

umask 077
signing=$(mktemp -d "${RUNNER_TEMP:-${TMPDIR:-/tmp}}/habbo-sign.XXXXXXXX")
trap 'rm -rf "$signing"' EXIT
printf '%s' "$KEYSTORE_BASE64" | base64 --decode > "$signing/release.keystore"
unset KEYSTORE_BASE64

"$zipalign" -P 16 -f 4 "$unsigned" "$signing/aligned.apk"
"$apksigner" sign \
  --ks "$signing/release.keystore" \
  --ks-key-alias "$KEY_ALIAS" \
  --ks-pass env:KEYSTORE_PASSWORD \
  --key-pass env:KEY_PASSWORD \
  --v1-signing-enabled true --v2-signing-enabled true \
  --v3-signing-enabled false --v4-signing-enabled false \
  --out "$signing/signed.apk" "$signing/aligned.apk"
unset KEYSTORE_PASSWORD KEY_PASSWORD

"$zipalign" -c -P 16 4 "$signing/signed.apk"
"$apksigner" verify --verbose --print-certs "$signing/signed.apk" > "$signing/verification.txt"
grep -Fx 'Verified using v1 scheme (JAR signing): true' "$signing/verification.txt"
grep -Fx 'Verified using v2 scheme (APK Signature Scheme v2): true' "$signing/verification.txt"
grep -Fx 'Number of signers: 1' "$signing/verification.txt"
grep -Fx "Signer #1 certificate SHA-256 digest: $expected_signer" "$signing/verification.txt" || {
  printf 'O certificado não corresponde à assinatura original do Habbo. Confira o keystore.\n' >&2
  exit 1
}
python3 work/make_token_apk80.py --verify "$signing/signed.apk"

mv -- "$signing/signed.apk" "$destination"
(
  cd -- "$(dirname -- "$destination")"
  name=$(basename -- "$destination")
  sha256sum -- "$name" > "$name.sha256"
)
