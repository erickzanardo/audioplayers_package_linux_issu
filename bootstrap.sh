#!/usr/bin/env bash

set -xeuo pipefail

CUR="$(dirname "$(realpath "${BASH_SOURCE[0]}")" )"
IGNORE="${CUR}/ignore"

if [[ ! -d "$IGNORE" ]]; then
  mkdir "$IGNORE"
fi

if ! type patchelf >/dev/null; then
  echo "You do not have `patchelf` installed, which is required"
  exit 42
fi

if ! type git >/dev/null; then
  echo "You do not have `git` installed, which is required"
  exit 42
fi

FASTFORGE="${IGNORE}/fastforge"
if [[ ! -d "$FASTFORGE" ]]; then
  rm -f "${CUR}/dart.md5"
  git clone https://github.com/chris-forks/fastforge -b hack-gstreamer "$FASTFORGE"
fi

# Download script to patch elfs
GSTREAMER_SCRIPT="${IGNORE}/linuxdeploy-plugin-gstreamer.sh"
curl -L https://raw.githubusercontent.com/linuxdeploy/linuxdeploy-plugin-gstreamer/refs/heads/master/linuxdeploy-plugin-gstreamer.sh -o "$GSTREAMER_SCRIPT"

# Don't exit if $LINUX_DEPLOY not set
sed -i 's/exit 3/# exit 3/' "${GSTREAMER_SCRIPT}"
# Mock out call to linuxdeploy binary
sed -i 's/.*\$LINUXDEPLOY.*appdir/# Do not call LINUXDEPLOY/' "${GSTREAMER_SCRIPT}"

sudo chmod +x "$GSTREAMER_SCRIPT"

# Download appimagetool
APPIMAGETOOL="${IGNORE}/appimagetool"
curl -L https://github.com/AppImage/appimagetool/releases/download/continuous/appimagetool-x86_64.AppImage -o "$APPIMAGETOOL"
sudo chmod +x "$APPIMAGETOOL"

cat << EOF
You now have all required dependencies.

You can now build an appimage container with:

./fastforge.sh
EOF
