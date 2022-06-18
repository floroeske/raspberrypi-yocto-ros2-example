# A Yocto ROS2 example project for the Raspberry Pi

Using:
* Yocto Kirkstone
* ROS2 Galactic

# Clone

```
git clone https://github.com/floroeske/raspberrypi-yocto-ros2-example.git
cd raspberrypi-yocto-ros2-example
git submodule init
git submodule update
```

# Build

## Source Yocto environment:

```
cd ./poky
source oe-init-build-env
cd ../..
```

## Generate Yocto configuration files

```
./create-bitbake-conf.sh
```


## Build

The first build takes a long time. The build is cached in ~/cache (this can be changed in local.conf). The Yocto cache can get quite large (~15GB).

```
bitbake core-image-minimal
```

A successful build will create a 'core-image-minimal-raspberrypi3-64-*.rootfs.wic.bz2' image file in './poky/build/tmp/deploy/images/raspberrypi3-64/' which contains an image file which can be written to a SD card and booted.
