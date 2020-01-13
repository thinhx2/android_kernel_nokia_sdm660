#!/bin/bash

echo "------------------------------------------------------"
echo "Kernel Source For FIH-SDM660-2018 Models"
echo "Lets Compile kernel with GCC. sit Back & Have A coffee "
echo "------------------------------------------------------"

path=
password=

cd
mkdir Black_Caps-Edition
git clone https://github.com/RaghuVarma331/aarch64-linux-android-4.9.git -b master --depth=1 aarch64-linux-android-4.9
cd kernel
clear
export ARCH=arm64
export CROSS_COMPILE=$path/aarch64-linux-android-4.9/bin/aarch64-linux-android-
mkdir output
make -C $(pwd) O=output SAT-perf_defconfig
make -j32 -C $(pwd) O=output
cp -r out/arch/arm64/boot/Image.gz-dtb $path/kernel/DRG_sprout
cd DRG_sprout
zip -r Black_Caps-Edition-10.0-GCC-FIH-SDM660-2018-$(date +"%Y%m%d").zip META-INF patch tools Image.gz-dtb anykernel.sh
cp -r Black_Caps-Edition-10.0-GCC-FIH-SDM660-2018-$(date +"%Y%m%d").zip $path/Black_Caps-Edition
cd
cd $path
cd Black_Caps-Edition
echo Sending build to sourceforge..
sshpass -p $password rsync -avP -e ssh Black_Caps**.zip raghuvarma331@frs.sourceforge.net:/home/frs/project/drg-sprout/Black_Caps-Edition



echo "--------------------------------------------"
echo "All Right now flash at your own risk"
echo "Flashable Zip located in Black_Caps-Edition Folder"
echo "Good Bye ..!! @ RaghuVarma "
echo "--------------------------------------------"
