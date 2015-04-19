#!/bin/bash

KERNEL_DIR=$PWD
ZIMAGE=$KERNEL_DIR/arch/arm/boot/zImage
BUILD_START=$(date +"%s")
export ARCH=arm
export SUBARCH=arm
export KBUILD_BUILD_USER="culcalkin"
export KBUILD_BUILD_HOST="str4ng3r"
export CROSS_COMPILE=~/UTC4.8/bin/arm-eabi-
compile_kernel ()
{
echo "***********************************************"
echo "         Compiling Culcalkin kernel             "
echo "***********************************************"
make clean && make mrproper
make falcon_defconfig
make -j4
if ! [ -a $ZIMAGE ];
then
echo " Kernel Compilation failed! Fix the errors! "
exit 1
fi
}
case $1 in
clean)
make ARCH=arm -j3 clean mrproper
rm -rf include/linux/autoconf.h
;;
*)
compile_kernel
;;
esac
BUILD_END=$(date +"%s")
DIFF=$(($BUILD_END - $BUILD_START))
echo "Build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds."
