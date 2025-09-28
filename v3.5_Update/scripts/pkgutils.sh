#!/bin/bash
error() {
set +x
rm -f '/root/Desktop/v3.5 Update Combo/scripts/next.desktop'
kdialog --title "Failed To Install v3.5 Update Combo" --error "An unexpected critical error has occured during the installation. \nPlease copy the console output and send them to the development team of Red Star OS 3.5 on discord. \nDiscord server invite link: discord.gg/MY68R2Quq5\n\nWe apologize for the inconvenience. \nThe installation script will now stop. "
trap '' ERR
bash
exit
}
yumerror() {
set +x
kdialog --title "Failed To Install v3.5 Update Combo" --error "Failed to install necessary development tools via 'yum install'. \nPlease make sure the Red Star OS 3.5 installation image is inserted into the device and the built-in yum repo on the image can be accessed normally. \nIf you've already installed all components under the development category and do not need to repeat this process, just ignore this message. \n\nWe apologize for the disruption. \nClick 'OK' to continue... "
}
Install() {
Extract $1 $2 || return 1
mkdir W0RK || return 1
cd W0RK || return 1
local og1=$1 || return 1
shift 2 || return 1
../configure --prefix=/usr $@ || return 1
make -j$(cat /proc/cpuinfo | grep "processor" | wc -l) || return 1
make install || return 1
CleanUp $og1 || return 1
return 0
}
InstallCross64() {
Extract $1 $2 || return 1
mkdir W0RK || return 1
cd W0RK || return 1
local og1=$1 || return 1
shift 2 || return 1
../configure --target=x86_64-linux-gnu --prefix=/opt/Cross64 $@ || return 1
make -j$(cat /proc/cpuinfo | grep "processor" | wc -l) || return 1
make install || return 1
CleanUp $og1 || return 1
return 0
}
Extract() {
cd /workspace || return 1
tar xvf /root/Desktop/v3.5\ Update\ Combo/packages/$1.tar.$2 || return 1
cd $1 || return 1
return 0
}
CleanUp() {
cd /workspace || return 1
rm -rf $1 || return 1
return 0
}
KernelInstall() {
cd /usr/src/kernels || return 1
Extract linux-$1 $2 || return 1
make allyesconfig || return 1
make -j$(cat /proc/cpuinfo | grep "processor" | wc -l) || return 1
make modules_install || return 1
make install || true || return 1
make headers_install INSTALL_HDR_PATH=/usr || return 1
sed -i 's/^default=[0-9]\+/default=0/' '/boot/grub/grub.conf' || return 1
cd /workspace || return 1
return 0
}