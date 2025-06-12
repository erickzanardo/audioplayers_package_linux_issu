#!/usr/bin/env bash

set -euo pipefail

CUR="$(dirname "$(realpath "${BASH_SOURCE[0]}")" )"

MONOREPO_ROOT='/home/chris/git/fastforge'
ROOT="${MONOREPO_ROOT}/packages/fastforge"

CHECKSUM_FILE="${CUR}/dart.md5"
CHECKSUM=$(find "${MONOREPO_ROOT}" -name '*.dart' | sort | xargs cat | md5sum)

if [[ -f "${CHECKSUM_FILE}" ]]; then
  echo "Found previous checksum file at ${CHECKSUM_FILE}"
  if [[ "${CHECKSUM}" == "$(< "${CHECKSUM_FILE}")" ]]; then
    echo "no change since checksum file written"
  else
    echo "your checksum file is outdated!"
    pushd "${ROOT}"
      flutter pub get
    popd
    echo "$CHECKSUM" > "${CHECKSUM_FILE}"
  fi
else
  echo "No previous checksum file at ${CHECKSUM_FILE}, writing one"
  echo "$CHECKSUM" > "${CHECKSUM_FILE}"
fi

# Ensure it can find appimagetool and linuxdeploy-plugin-gstreamer.sh
PATH="$CUR:${PATH}"
# Dir that contains gst-plugin-scanner, check if this is right
GSTREAMER_HELPERS_DIR='/usr/lib/gstreamer-1.0'
GSTREAMER_VERSION='1.0'
LINUXDEPLOY="${CUR}/"
dart "${ROOT}/bin/main.dart" package --platform linux --targets appimage
