This is a working environment to create an image that can be written to the Arris DG3270A cable modem.

The command scripts/build_image.sh will download the sources and compile them to create a rootfs that can me merged with the original to upgrade some of the modems programs and capabilities.

git clone --depth=1 -b v2014.11 https://github.com/protectivedad/DG3270A-Atom-Buildroot.git atom-buildroot
cd atom-buildroot
./scripts/build_image.sh

The directory atom-buildroot/buildroot/output/images will contain the root filesystem archives that can be used to merge with the original firmware.