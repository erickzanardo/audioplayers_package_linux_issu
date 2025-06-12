#!/usr/bin/env bash

set -euo pipefail

CUR="$(dirname "$(realpath "${BASH_SOURCE[0]}")" )"

MONOREPO_ROOT="${CUR}/ignore/fastforge"

if [[ ! -d "$MONOREPO_ROOT" ]]; then
  echo "Did not find a fastforge repo at $MONOREPO_ROOT" >&2
  echo "Did you run the ./bootstrap.sh script?" >&2
  exit 42
fi

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
  echo "No previous checksum file at ${CHECKSUM_FILE}"
  pushd "${ROOT}"
    flutter pub get
  popd
  echo "$CHECKSUM" > "${CHECKSUM_FILE}"
fi

# Ensure it can find appimagetool and linuxdeploy-plugin-gstreamer.sh
PATH="${CUR}/ignore:${PATH}"
# Dir that contains gst-plugin-scanner, check if this is right
GSTREAMER_HELPERS_DIR='/usr/lib/gstreamer-1.0'
if [[ ! -f "${GSTREAMER_HELPERS_DIR}/gst-plugin-scanner" ]]; then
  echo "Tried to use ${GSTREAMER_HELPERS_DIR} as the GSTREAMER_HELPERS_DIR but it did not have gst-plugin-scanner" >&2
  echo "You either forgot to install gst-plugins-good or you need to hack this script to have a different \$GSTREAMER_HELPERS_DIR var" >&2
  exit 42
fi
GSTREAMER_VERSION='1.0'
dart "${ROOT}/bin/main.dart" package --platform linux --targets appimage
