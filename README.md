# audioplayers_package_linux_issue

This repository is a minimal reproducible example of the issue with the `audioplayers` package on Linux when it is bundled via an appimage distribution.

To fetch dependencies, run the bootstrap script:

```bash
./bootstrap.sh
```

Then, run the fastforge wrapper script:

```bash
./fastforge.sh
```

To run the binary, just execute the generated AppImage file:

```bash
./dist/1.0.0+1/audioplayers_package_linux_issue-1.0.0+1-linux.AppImage
```
