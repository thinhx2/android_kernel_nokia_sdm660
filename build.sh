#!/bin/bash

echo "------------------------------------------------------"
echo "Kernel Source For Nokia 6.1 Plus"
echo "Lets Compile kernel with Clang. sit Back & Have A coffee "
echo "------------------------------------------------------"

pathtoclang=/root/clang
pathtogcc=/root/aarch64-linux-android-4.9
password=

cd
git clone https://github.com/RaghuVarma331/aarch64-linux-android-4.9.git -b master --depth=1 aarch64-linux-android-4.9
git clone https://github.com/RaghuVarma331/clang.git -b clang-r353983c --depth=1 clang
mkdir Black_Caps-Edition


cd kernel
clear
make O=out ARCH=arm64 SAT-perf_defconfig
PATH=$pathtoclang/bin:$pathtogcc/bin:${PATH} \
make -j$(nproc --all) O=out \
                      ARCH=arm64 \
                      CC=clang \
                      CLANG_TRIPLE=aarch64-linux-gnu- \
                      CROSS_COMPILE=aarch64-linux-android-

cp -r out/arch/arm64/boot/Image.gz-dtb /root/kernel/DRG_sprout
cd DRG_sprout
zip -r Black_Caps-Edition-10.0-CLANG-DRG_sprout-$(date +"%Y%m%d").zip META-INF patch tools Image.gz-dtb anykernel.sh
cp -r Black_Caps-Edition-10.0-CLANG-DRG_sprout-$(date +"%Y%m%d").zip  /root/Black_Caps-Edition
cd
cd Black_Caps-Edition
clear
echo Sending build to sourceforge..
sshpass -p $password rsync -avP -e ssh Black_Caps**.zip raghuvarma331@frs.sourceforge.net:/home/frs/project/drg-sprout/Black_Caps-Edition


echo "--------------------------------------------"
echo "All Right now flash at your own risk"
echo "Flashable Zip located in Black_Caps-Edition Folder"
echo "Good Bye ..!! @ RaghuVarma "
echo "--------------------------------------------"
