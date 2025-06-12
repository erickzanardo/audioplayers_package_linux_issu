# audioplayers_package_linux_issue

This repository is a minimal reproducible example of the issue with the `audioplayers` package on Linux when it is bundled via an appimage distribution.

You will need to have the fastforge CLI to be able to build the example.
https://fastforge.dev/

The command to build the binary is

```bash
fastforge package --platform linux --targets appimage
```


To run the binary, just execute the generated AppImage file:

```bash
./dist/1.0.0+1/audioplayers_package_linux_issue-1.0.0+1-linux.AppImage
```

```bash
sudo pacman -S gst-plugins-good

curl -LO https://raw.githubusercontent.com/linuxdeploy/linuxdeploy-plugin-gstreamer/refs/heads/master/linuxdeploy-plugin-gstreamer.sh
sudo chmod +x ./linuxdeploy-plugin-gstreamer.sh

# This will launch the release build of the flutter app and strace it
# Click on the button in the app when it starts, and then close it.
# You should now have an ./strace.log file
./trace.sh

curl -L https://github.com/AppImage/appimagetool/releases/download/continuous/appimagetool-x86_64.AppImage -o appimagetool

sudo chmod +x ./appimagetool

./fastforge.sh
```
