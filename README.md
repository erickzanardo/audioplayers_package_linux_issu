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
