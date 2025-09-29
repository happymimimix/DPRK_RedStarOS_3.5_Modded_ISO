#!/bin/bash
error() {
set +x
rm -f '/root/Desktop/v3.5 Update Combo/scripts/next.desktop'
kdialog --title "Failed To Install v3.5 Update Combo" --error "An unexpected critical error has occured during the installation. \nPlease copy the console output and send them to the development team of Red Star OS 3.5 on discord. \nDiscord server invite link: discord.gg/MY68R2Quq5\n\nWe apologize for the inconvenience. \nThe installation script will now stop. "
trap '' ERR
exec bash -i
exit
}
yumerror() {
set +x
kdialog --title "Failed To Install v3.5 Update Combo" --error "Failed to install necessary development tools via 'yum install'. \nPlease make sure the Red Star OS 3.5 installation image is inserted into the device and the built-in yum repo on the image can be accessed normally. \nIf you've already installed all components under the development category and do not need to repeat this process, just ignore this message. \n\nWe apologize for the disruption. \nClick 'OK' to continue... "
}
title() { printf '\033]0;%s\007' "$*"; }
Install() {
set -x
set +e
title Installing $1
Extract $1 $2 || return 1
mkdir W0RK || return 1
cd W0RK || return 1
local og1=$1 || return 1
shift 2 || return 1
title Installing $og1 \[Configuring\]
../configure --prefix=/usr $@ || return 1
title Installing $og1 \[Compiling\]
make -j$(cat /proc/cpuinfo | grep "processor" | wc -l) || return 1
title Installing $og1 \[Deploying\]
make install || return 1
CleanUp $og1 || return 1
return 0
}
InstallJ1() {
set -x
set +e
title Installing $1
Extract $1 $2 || return 1
mkdir W0RK || return 1
cd W0RK || return 1
local og1=$1 || return 1
shift 2 || return 1
title Installing $og1 \[Configuring\]
../configure --prefix=/usr $@ || return 1
title Installing $og1 \[Compiling\]
make -j1 || return 1
title Installing $og1 \[Deploying\]
make install || return 1
CleanUp $og1 || return 1
return 0
}
InstallRoot() {
set -x
set +e
title Installing $1
Extract $1 $2 || return 1
mkdir W0RK || return 1
cd W0RK || return 1
local og1=$1 || return 1
shift 2 || return 1
title Installing $og1 \[Configuring\]
../configure --prefix= $@ || return 1
title Installing $og1 \[Compiling\]
make -j$(cat /proc/cpuinfo | grep "processor" | wc -l) || return 1
title Installing $og1 \[Deploying\]
make install || return 1
CleanUp $og1 || return 1
return 0
}
InstallRootJ1() {
set -x
set +e
title Installing $1
Extract $1 $2 || return 1
mkdir W0RK || return 1
cd W0RK || return 1
local og1=$1 || return 1
shift 2 || return 1
title Installing $og1 \[Configuring\]
../configure --prefix= $@ || return 1
title Installing $og1 \[Compiling\]
make -j1 || return 1
title Installing $og1 \[Deploying\]
make install || return 1
CleanUp $og1 || return 1
return 0
}
InstallCross64() {
set -x
set +e
title Installing $1 For Cross-x86_64
Extract $1 $2 || return 1
mkdir W0RK || return 1
cd W0RK || return 1
local og1=$1 || return 1
shift 2 || return 1
title Installing $og1 For Cross-x86_64 \[Configuring\]
../configure --target=x86_64-linux-gnu --prefix=/opt/Cross64 $@ || return 1
title Installing $og1 For Cross-x86_64 \[Compiling\]
make -j$(cat /proc/cpuinfo | grep "processor" | wc -l) || return 1
title Installing $og1 For Cross-x86_64 \[Deploying\]
make install || return 1
CleanUp $og1 || return 1
return 0
}
InstallCross64J1() {
set -x
set +e
title Installing $1 For Cross-x86_64
Extract $1 $2 || return 1
mkdir W0RK || return 1
cd W0RK || return 1
local og1=$1 || return 1
shift 2 || return 1
title Installing $og1 For Cross-x86_64 \[Configuring\]
../configure --target=x86_64-linux-gnu --prefix=/opt/Cross64 $@ || return 1
title Installing $og1 For Cross-x86_64 \[Compiling\]
make -j1 || return 1
title Installing $og1 For Cross-x86_64 \[Deploying\]
make install || return 1
CleanUp $og1 || return 1
return 0
}
InstallNative64() {
set -x
set +e
title Installing $1 For x86_64
export CROSS_PREFIX=/opt/Cross64
export TARGET=x86_64-linux-gnu
export CC=${CROSS_PREFIX}/bin/${TARGET}-gcc
export GCC=${CROSS_PREFIX}/bin/${TARGET}-gcc
export CXX=${CROSS_PREFIX}/bin/${TARGET}-g++
export GXX=${CROSS_PREFIX}/bin/${TARGET}-g++
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
export DLLTOOL=${CROSS_PREFIX}/bin/${TARGET}-dlltool
export GCOV=${CROSS_PREFIX}/bin/${TARGET}-gcov
export GCOV_DUMP=${CROSS_PREFIX}/bin/${TARGET}-gcov-dump
export GCOV_TOOL=${CROSS_PREFIX}/bin/${TARGET}-gcov-tool
export GPROF=${CROSS_PREFIX}/bin/${TARGET}-gprof
export ADDR2LINE=${CROSS_PREFIX}/bin/${TARGET}-addr2line
$CC --help
$GCC --help
$CXX --help
$GXX --help
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
$DLLTOOL --help
$GCOV --help
$GCOV_DUMP --help
$GCOV_TOOL --help
$GPROF --help
$ADDR2LINE --help
Extract $1 $2 || return 1
mkdir W0RK || return 1
cd W0RK || return 1
local og1=$1 || return 1
shift 2 || return 1
title Installing $og1 For x86_64 \[Configuring\]
../configure --target=x86_64-linux-gnu --prefix=/usr --with-sysroot=/opt/Cross64/x86_64-linux-gnu --includedir=/opt/Cross64/x86_64-linux-gnu/include $@ || return 1
title Installing $og1 For x86_64 \[Compiling\]
make -j$(cat /proc/cpuinfo | grep "processor" | wc -l) || return 1
title Installing $og1 For x86_64 \[Deploying\]
make install || return 1
CleanUp $og1 || return 1
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
return 0
}
InstallNative64J1() {
set -x
set +e
title Installing $1 For x86_64
export CROSS_PREFIX=/opt/Cross64
export TARGET=x86_64-linux-gnu
export CC=${CROSS_PREFIX}/bin/${TARGET}-gcc
export GCC=${CROSS_PREFIX}/bin/${TARGET}-gcc
export CXX=${CROSS_PREFIX}/bin/${TARGET}-g++
export GXX=${CROSS_PREFIX}/bin/${TARGET}-g++
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
export DLLTOOL=${CROSS_PREFIX}/bin/${TARGET}-dlltool
export GCOV=${CROSS_PREFIX}/bin/${TARGET}-gcov
export GCOV_DUMP=${CROSS_PREFIX}/bin/${TARGET}-gcov-dump
export GCOV_TOOL=${CROSS_PREFIX}/bin/${TARGET}-gcov-tool
export GPROF=${CROSS_PREFIX}/bin/${TARGET}-gprof
export ADDR2LINE=${CROSS_PREFIX}/bin/${TARGET}-addr2line
$CC --help
$GCC --help
$CXX --help
$GXX --help
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
$DLLTOOL --help
$GCOV --help
$GCOV_DUMP --help
$GCOV_TOOL --help
$GPROF --help
$ADDR2LINE --help
Extract $1 $2 || return 1
mkdir W0RK || return 1
cd W0RK || return 1
local og1=$1 || return 1
shift 2 || return 1
title Installing $og1 For x86_64 \[Configuring\]
../configure --target=x86_64-linux-gnu --prefix=/usr --with-sysroot=/opt/Cross64/x86_64-linux-gnu --includedir=/opt/Cross64/x86_64-linux-gnu/include $@ || return 1
title Installing $og1 For x86_64 \[Compiling\]
make -j1 || return 1
title Installing $og1 For x86_64 \[Deploying\]
make install || return 1
CleanUp $og1 || return 1
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
return 0
}
InstallNative64Root() {
set -x
set +e
title Installing $1 For x86_64
export CROSS_PREFIX=/opt/Cross64
export TARGET=x86_64-linux-gnu
export CC=${CROSS_PREFIX}/bin/${TARGET}-gcc
export GCC=${CROSS_PREFIX}/bin/${TARGET}-gcc
export CXX=${CROSS_PREFIX}/bin/${TARGET}-g++
export GXX=${CROSS_PREFIX}/bin/${TARGET}-g++
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
export DLLTOOL=${CROSS_PREFIX}/bin/${TARGET}-dlltool
export GCOV=${CROSS_PREFIX}/bin/${TARGET}-gcov
export GCOV_DUMP=${CROSS_PREFIX}/bin/${TARGET}-gcov-dump
export GCOV_TOOL=${CROSS_PREFIX}/bin/${TARGET}-gcov-tool
export GPROF=${CROSS_PREFIX}/bin/${TARGET}-gprof
export ADDR2LINE=${CROSS_PREFIX}/bin/${TARGET}-addr2line
$CC --help
$GCC --help
$CXX --help
$GXX --help
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
$DLLTOOL --help
$GCOV --help
$GCOV_DUMP --help
$GCOV_TOOL --help
$GPROF --help
$ADDR2LINE --help
Extract $1 $2 || return 1
mkdir W0RK || return 1
cd W0RK || return 1
local og1=$1 || return 1
shift 2 || return 1
title Installing $og1 For x86_64 \[Configuring\]
../configure --target=x86_64-linux-gnu --prefix= --with-sysroot=/opt/Cross64/x86_64-linux-gnu --includedir=/opt/Cross64/x86_64-linux-gnu/include $@ || return 1
title Installing $og1 For x86_64 \[Compiling\]
make -j$(cat /proc/cpuinfo | grep "processor" | wc -l) || return 1
title Installing $og1 For x86_64 \[Deploying\]
make install || return 1
CleanUp $og1 || return 1
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
return 0
}
InstallNative64RootJ1() {
set -x
set +e
title Installing $1 For x86_64
export CROSS_PREFIX=/opt/Cross64
export TARGET=x86_64-linux-gnu
export CC=${CROSS_PREFIX}/bin/${TARGET}-gcc
export GCC=${CROSS_PREFIX}/bin/${TARGET}-gcc
export CXX=${CROSS_PREFIX}/bin/${TARGET}-g++
export GXX=${CROSS_PREFIX}/bin/${TARGET}-g++
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
export DLLTOOL=${CROSS_PREFIX}/bin/${TARGET}-dlltool
export GCOV=${CROSS_PREFIX}/bin/${TARGET}-gcov
export GCOV_DUMP=${CROSS_PREFIX}/bin/${TARGET}-gcov-dump
export GCOV_TOOL=${CROSS_PREFIX}/bin/${TARGET}-gcov-tool
export GPROF=${CROSS_PREFIX}/bin/${TARGET}-gprof
export ADDR2LINE=${CROSS_PREFIX}/bin/${TARGET}-addr2line
$CC --help
$GCC --help
$CXX --help
$GXX --help
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
$DLLTOOL --help
$GCOV --help
$GCOV_DUMP --help
$GCOV_TOOL --help
$GPROF --help
$ADDR2LINE --help
Extract $1 $2 || return 1
mkdir W0RK || return 1
cd W0RK || return 1
local og1=$1 || return 1
shift 2 || return 1
title Installing $og1 For x86_64 \[Configuring\]
../configure --target=x86_64-linux-gnu --prefix= --with-sysroot=/opt/Cross64/x86_64-linux-gnu --includedir=/opt/Cross64/x86_64-linux-gnu/include $@ || return 1
title Installing $og1 For x86_64 \[Compiling\]
make -j1 || return 1
title Installing $og1 For x86_64 \[Deploying\]
make install || return 1
CleanUp $og1 || return 1
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
return 0
}
Remove() {
set -x
set +e
title Uninstalling $1
Extract $1 $2 || return 1
mkdir W0RK || return 1
cd W0RK || return 1
local og1=$1 || return 1
shift 2 || return 1
title Uninstalling $og1 \[Configuring\]
../configure --prefix=/usr $@ || return 1
title Uninstalling $og1 \[Erasing\]
make uninstall || return 1
CleanUp $og1 || return 1
return 0
}
RemoveRoot() {
set -x
set +e
title Uninstalling $1
Extract $1 $2 || return 1
mkdir W0RK || return 1
cd W0RK || return 1
local og1=$1 || return 1
shift 2 || return 1
../configure --prefix= $@ || return 1
make uninstall || return 1
CleanUp $og1 || return 1
return 0
}
Check() {
set -x
set +e
title Checking $1
Extract $1 $2 || return 1
local og1=$1 || return 1
shift 2 || return 1
title Checking $1
./configure $@ --help || return 1
CleanUp $og1 || return 1
return 0
}
Extract() {
set -x
set +e
title Extracting $1
cd /workspace || return 1
tar xvf /root/Desktop/v3.5\ Update\ Combo/packages/$1.tar.$2 || return 1
cd $1 || return 1
return 0
}
CleanUp() {
set -x
set +e
title Cleaning $1
cd /workspace || return 1
rm -rf $1 || return 1
return 0
}
KernelInstall() {
set -x
set +e
title Installing Kernel $1
cd /usr/src/kernels || return 1
Extract linux-$1 $2 || return 1
title Installing Kernel $1 \[Configuring\]
make allyesconfig || return 1
title Installing Kernel $1 \[Compiling\]
make -j$(cat /proc/cpuinfo | grep "processor" | wc -l) || return 1
title Installing Kernel $1 \[Deploying Modules\]
make modules_install || return 1
title Installing Kernel $1 \[Deploying RamFS \& vmlinuz\]
make install || true || return 1
title Installing Kernel $1 \[Deploying Headers\]
make headers_install INSTALL_HDR_PATH=/usr || return 1
sed -i 's/^default=[0-9]\+/default=0/' '/boot/grub/grub.conf' || return 1
title Cleaning Kernel $1
cd /workspace || return 1
return 0
}
