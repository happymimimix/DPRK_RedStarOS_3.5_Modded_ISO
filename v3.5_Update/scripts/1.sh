#!/bin/bash
kdialog --title "Install v3.5 Update Combo" --error "This tool will guide you through the installation process of the unofficial v3.5 update for Red Star OS 3.0. \n\nThis will upgrade the system kernel to 4.19 x86_64 along with updates to many other critical system components and libraries including but not limited to gcc and yum. \n\nThe process is fully automatic, do not touch anything except typing your login password when asked. \nYour device will reboot for a couple of times during the process, it's recommended to set up automatic login in \"System Preferences -> Accounts -> Login Options -> Automatic Login\" so the amount of times the password need to be typed can be reduced. \n\nClick 'OK' when ready... "
set -x
source '/root/Desktop/v3.5 Update Combo/scripts/pkgutils.sh'
trap 'error' ERR
set +e
rm -rf /workspace
mkdir /workspace
cd /workspace
trap 'yumerror' ERR
yum groupinstall "C/C++ Development Environment" "Develop Editors" "Development Tools" "Development Libraries" -y --skip-broken
trap 'error' ERR
Install bc-1.07.1 gz --enable-shared
Install make-4.2.1 gz --with-libintl-prefix --with-libiconv-prefix --with-gnu-ld
Install gmp-4.3.2 bz2 --enable-cxx --enable-shared
Install mpfr-2.4.2 bz2 --enable-shared
Install mpc-0.8.1 gz --enable-shared
Install isl-0.14 bz2
Install gcc-6.5.0 xz --mandir=/usr/share/man --infodir=/usr/share/info --enable-bootstrap --enable-threads=posix --enable-checking=release --with-system-zlib --enable-__cxa_atexit --disable-libunwind-exceptions --with-tune=generic --enable-languages=ada,c,c++,fortran,go,java,jit,lto,objc,obj-c++ --enable-shared --enable-multilib --enable-host-shared
Install ncurses-5.6 gz
Install gmp-6.2.1 bz2 --enable-cxx --enable-shared
Install mpfr-4.1.0 bz2 --enable-shared
Install mpc-1.2.1 gz --enable-shared
Install isl-0.24 bz2
Install nettle-3.4.1 gz --enable-shared --enable-threads
Install libtasn1-4.10 gz
Install libunistring-1.1 gz
cd /workspace
Extract openssl-1.0.2u gz
./config --openssldir=/usr/ssl
make -j$(cat /proc/cpuinfo | grep "processor" | wc -l)
make install
CleanUp openssl-1.0.2u
Install unbound-release-1.8.3 gz
Install libffi-3.3 gz
Install p11-kit-0.23.18.1 gz
Install gnutls-3.3.30 xz --enable-shared --enable-plugins
Install wget-1.19.5 gz
Install m4-1.4.18 xz
Install libtool-2.4.6 xz --enable-shared
Install autoconf-2.69 xz
Install bison-3.5.4 xz 
Install gawk-4.2.1 xz
Install sed-4.4 xz
Install Python-3.7.6 xz --enable-optimizations --with-pydebug
Install gdb-7.12 xz
Install binutils-2.34 xz
InstallCross64 binutils-2.34 xz
bash
KernelInstall 3.19.8 gz
echo "[Desktop Entry]" > '/root/Desktop/v3.5 Update Combo/scripts/next.desktop'
echo "Encoding=UTF-8" >> '/root/Desktop/v3.5 Update Combo/scripts/next.desktop'
echo "Type=Application" >> '/root/Desktop/v3.5 Update Combo/scripts/next.desktop'
echo "Exec=konsole -e bash -c \"cd /root/Desktop/v3.5\ Update\ Combo;  ./scripts/2.sh\"" >> '/root/Desktop/v3.5 Update Combo/scripts/next.desktop'
echo "Terminal=false" >> '/root/Desktop/v3.5 Update Combo/scripts/next.desktop'
echo "Name=v3.5 Update Combo" >> '/root/Desktop/v3.5 Update Combo/scripts/next.desktop'
echo "Categories=Applocation" >> '/root/Desktop/v3.5 Update Combo/scripts/next.desktop'
set +x
trap '' ERR
for ((i = 5; i > 0; i--)); do
echo -ne "Press any key in $i to abort automatic reboot... \r"
read -rs -n 1 -t 1 key
if [[ $key ]]; then
echo -e "\nReboot aborted. "
sleep 1
exec bash
fi
done
echo -e "\nRebooting now... "
sleep 1
reboot