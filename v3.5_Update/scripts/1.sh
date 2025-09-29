#!/bin/bash
kdialog --title "Install v3.5 Update Combo" --error "This tool will guide you through the installation process of the unofficial v3.5 update for Red Star OS 3.0. \n\nThis will upgrade the system kernel to 4.19 x86_64 along with updates to many other critical system components and libraries including but not limited to gcc and yum. \n\nThe process is fully automatic, do not touch anything except typing your login password when asked. \nYour device will reboot for a couple of times during the process, it's recommended to set up automatic login in \"System Preferences -> Accounts -> Login Options -> Automatic Login\" so the amount of times the password need to be typed can be reduced. \n\nClick 'OK' when ready... "
set -x
killall -9 -e artsd
source '/root/Desktop/v3.5 Update Combo/scripts/pkgutils.sh'
trap 'error' ERR
set +e
rm -rf /workspace
mkdir /workspace
cd /workspace
trap 'yumerror' ERR
yum install @"Development Tools" "kernel*" -y -x "*PAE*"
trap 'error' ERR
InstallJ1 bc-1.07.1 gz --enable-shared
Install make-4.2.1 gz --with-libintl-prefix --with-libiconv-prefix --with-gnu-ld
InstallJ1 gmp-4.3.2 bz2 --enable-cxx --enable-shared
InstallJ1 mpfr-2.4.2 bz2 --enable-shared
InstallJ1 mpc-0.8.1 gz --enable-shared
InstallJ1 isl-0.14 bz2
InstallJ1 zlib-1.2.11 xz
InstallRootJ1 zlib-1.2.11 xz
Install gcc-6.5.0 xz --mandir=/usr/share/man --infodir=/usr/share/info --enable-threads=posix --enable-checking=release --with-system-zlib --enable-__cxa_atexit --disable-libunwind-exceptions --with-tune=generic --enable-languages=ada,c,c++,fortran,go,java,jit,lto,objc,obj-c++ --enable-shared --enable-multilib --enable-host-shared --enable-lto --enable-libada --enable-libssp --enable-liboffloadmi=host --enable-objc-gc --enable-vtable-verify
Install ncurses-6.0 gz --with-ada
InstallJ1 gmp-6.2.1 bz2 --enable-cxx --enable-shared
InstallJ1 mpfr-4.1.0 bz2 --enable-shared
InstallJ1 mpc-1.2.1 gz --enable-shared
InstallJ1 isl-0.24 bz2
Install nettle-3.4.1 gz --enable-shared --enable-threads
Install libtasn1-4.10 gz
Install libunistring-1.1 gz
Install libiconv-1.16 gz
Install cpio-2.13 gz
title Installing openssl-1.0.2u
Extract openssl-1.0.2u gz
title Installing openssl-1.0.2u \[Configuring\]
./config --openssldir=/usr/ssl
title Installing openssl-1.0.2u \[Compiling\]
make -j$(cat /proc/cpuinfo | grep "processor" | wc -l)
title Installing openssl-1.0.2u \[Deploying\]
make install
CleanUp openssl-1.0.2u
Install expat-2.2.10 gz
Install unbound-1.12.0 gz
Install libffi-3.3 gz
Install p11-kit-0.23.18.1 gz
Install gnutls-3.3.30 xz --enable-shared --enable-plugins
Install wget-1.19.5 gz
Install m4-1.4.18 xz
Install libtool-2.4.6 xz --enable-shared
Install autoconf-2.69 xz
Install automake-1.15 xz
Install bison-3.5.4 xz 
Install gawk-4.2.1 xz
Install sed-4.4 xz
Install gdb-7.12 xz
Install binutils-2.34 xz
export CFLAGS="-O2 -g -fno-common"
Install glibc-2.23 xz --mandir=/usr/share/man --infodir=/usr/share/info --enable-shared --enable-profile --enable-multi-arch --enable-obsolete-rpc --disable-werror
unset CFLAGS
Install Python-3.7.6 xz --enable-optimizations --with-pydebug
rm -rf /opt/Cross64
mkdir /opt/Cross64
InstallCross64 binutils-2.34 xz
title Installing gcc-6.5.0 For Cross-x86_64
Extract gcc-6.5.0 xz
mkdir W0RK
cd W0RK
title Installing gcc-6.5.0 For Cross-x86_64 \[Configuring\]
../configure --target=x86_64-linux-gnu --prefix=/opt/Cross64 --without-headers --mandir=/opt/Cross64/share/man --infodir=/opt/Cross64/share/info --enable-bootstrap --enable-threads=posix --enable-checking=release --enable-__cxa_atexit --disable-libunwind-exceptions --with-tune=generic --enable-languages=c --enable-shared --enable-multilib --enable-host-shared
title Installing gcc-6.5.0 For Cross-x86_64 \[Compiling\]
make all-gcc -j$(cat /proc/cpuinfo | grep "processor" | wc -l)
title Installing gcc-6.5.0 For Cross-x86_64 \[Deploying\]
make install-gcc
CleanUp gcc-6.5.0
title Installing Kernel 2.6.38.8-24.rs3.0.i686 For Cross-x86_64
cd /usr/src/kernels/2.6.38.8-24.rs3.0.i686
title Installing Kernel 2.6.38.8-24.rs3.0.i686 For Cross-x86_64 \[Deploying Headers\]
make headers_install ARCH=x86_64 INSTALL_HDR_PATH=/opt/Cross64/x86_64-linux-gnu/include
cp -rnv /usr/include/* /opt/Cross64/x86_64-linux-gnu/include
export CROSS_PREFIX=/opt/Cross64
export TARGET=x86_64-linux-gnu
export CC=${CROSS_PREFIX}/bin/${TARGET}-gcc
export GCC=${CROSS_PREFIX}/bin/${TARGET}-gcc
#export CXX=${CROSS_PREFIX}/bin/${TARGET}-g++	#We don't have C++ yet
#export GXX=${CROSS_PREFIX}/bin/${TARGET}-g++	#We don't have C++ yet
export CPP=${CROSS_PREFIX}/bin/${TARGET}-cpp
export CXXFILT=${CROSS_PREFIX}/bin/${TARGET}-c++filt
export AR=${CROSS_PREFIX}/bin/${TARGET}-ar
export AS=${CROSS_PREFIX}/bin/${TARGET}-as
export LD=${CROSS_PREFIX}/bin/${TARGET}-ld
export NM=${CROSS_PREFIX}/bin/${TARGET}-nm
export RANLIB=${CROSS_PREFIX}/bin/${TARGET}-ranlib
export STRIP=${CROSS_PREFIX}/bin/${TARGET}-strip
export STRINGS=${CROSS_PREFIX}/bin/${TARGET}-strings
export SIZE=${CROSS_PREFIX}/bin/${TARGET}-size
export OBJCOPY=${CROSS_PREFIX}/bin/${TARGET}-objcopy
export OBJDUMP=${CROSS_PREFIX}/bin/${TARGET}-objdump
export READELF=${CROSS_PREFIX}/bin/${TARGET}-readelf
export ELFEDIT=${CROSS_PREFIX}/bin/${TARGET}-elfedit
#export DLLTOOL=${CROSS_PREFIX}/bin/${TARGET}-dlltool	#We don't have this tool yet
export GCOV=${CROSS_PREFIX}/bin/${TARGET}-gcov
export GCOV_DUMP=${CROSS_PREFIX}/bin/${TARGET}-gcov-dump
export GCOV_TOOL=${CROSS_PREFIX}/bin/${TARGET}-gcov-tool
export GPROF=${CROSS_PREFIX}/bin/${TARGET}-gprof
export ADDR2LINE=${CROSS_PREFIX}/bin/${TARGET}-addr2line
$CC --help
$GCC --help
#$CXX --help	#We don't have C++ yet
#$GXX --help	#We don't have C++ yet
$CPP --help
$CXXFILT --help
$AR --help
$AS --help
$LD --help
$NM --help
$RANLIB --help
$STRIP --help
$STRINGS --help
$SIZE --help
$OBJCOPY --help
$OBJDUMP --help
$READELF --help
$ELFEDIT --help
#$DLLTOOL --help	#We don't have this tool yet
$GCOV --help
$GCOV_DUMP --help
$GCOV_TOOL --help
$GPROF --help
$ADDR2LINE --help
title Installing glibc-2.23 For Cross-x86_64
Extract glibc-2.23 xz
mkdir W0RK
cd W0RK
export CFLAGS="-O2 -g -fno-common"
title Installing glibc-2.23 For Cross-x86_64 \[Configuring\]
../configure --prefix=/opt/Cross64/x86_64-linux-gnu --mandir=/opt/Cross64/share/man --infodir=/opt/Cross64/share/info --host=x86_64-linux-gnu --build=i386-pc-linux-gnu --with-headers=/opt/Cross64/x86_64-linux-gnu/include --enable-shared --enable-profile --enable-multi-arch --enable-obsolete-rpc --disable-werror
title Installing glibc-2.23 For Cross-x86_64 \[Deploying Headers\]
make install-headers
unset CFLAGS
CleanUp glibc-2.23
InstallCross64 libiconv-1.16 gz
InstallCross64 gcc-6.5.0 xz --mandir=/opt/Cross64/share/man --infodir=/opt/Cross64/share/info --with-build-sysroot=/opt/Cross64/x86_64-linux-gnu --includedir=/opt/Cross64/x86_64-linux-gnu/include --enable-threads=posix --enable-checking=release --enable-__cxa_atexit --disable-libunwind-exceptions --with-tune=generic --enable-languages=c,c++ --enable-shared --enable-multilib --enable-host-shared
InstallCross64 glibc-2.23 xz --prefix=/opt/Cross64/x86_64-linux-gnu --mandir=/opt/Cross64/share/man --infodir=/opt/Cross64/share/info --host=x86_64-linux-gnu --build=i386-pc-linux-gnu --with-headers=/opt/Cross64/x86_64-linux-gnu/include --enable-shared --enable-profile --enable-multi-arch --enable-obsolete-rpc --disable-werror
InstallCross64 gcc-6.5.0 xz --mandir=/opt/Cross64/share/man --infodir=/opt/Cross64/share/info --with-build-sysroot=/opt/Cross64/x86_64-linux-gnu --includedir=/opt/Cross64/x86_64-linux-gnu/include --enable-threads=posix --enable-checking=release --enable-__cxa_atexit --disable-libunwind-exceptions --with-tune=generic --enable-languages=ada,c,c++,fortran,go,java,jit,lto,objc,obj-c++ --enable-shared --enable-multilib --enable-host-shared --enable-lto --enable-libada --enable-libssp --enable-liboffloadmi=host --enable-objc-gc --enable-vtable-verify
unset CROSS_PREFIX
unset TARGET
unset CC
unset GCC
unset CXX
unset GXX
unset CPP
unset CXXFILT
unset AR
unset AS
unset LD
unset NM
unset RANLIB
unset STRIP
unset STRINGS
unset SIZE
unset OBJCOPY
unset OBJDUMP
unset READELF
unset ELFEDIT
unset DLLTOOL
unset GCOV
unset GCOV_DUMP
unset GCOV_TOOL
unset GPROF
unset ADDR2LINE
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
if read -rs -n 1 -t 1; then
echo -e "\nReboot aborted. "
sleep 1
exec bash -i
exit
fi
done
echo -e "\nRebooting now... "
sleep 1
reboot
