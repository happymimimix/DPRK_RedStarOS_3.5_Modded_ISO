#!/bin/bash
error() {
kdialog --title "Failed To Install v3.5 Update Combo" --error "An unexpected critical error has occured during the installation. \nPlease copy the console output and send them to the development team of Red Star OS 3.5 on discord. \nDiscord server invite link: discord.gg/MY68R2Quq5\n\nWe apologize for the inconvenience. \nThe installation script will now stop. "
}
scripterror() {
rm -f '/root/Desktop/v3.5 Update Combo/scripts/next.desktop'
kdialog --title "Failed To Install v3.5 Update Combo" --error "An unexpected critical error has occured during the installation. \nPlease copy the console output and send them to the development team of Red Star OS 3.5 on discord. \nDiscord server invite link: discord.gg/MY68R2Quq5\n\nWe apologize for the inconvenience. \nThe installation script will now stop. "
trap '' ERR
cp -f ~/.bashrc /root/Desktop/v3.5\ Update\ Combo/scripts/trap
echo 'set -x' >> /root/Desktop/v3.5\ Update\ Combo/scripts/trap
echo 'set +e' >> /root/Desktop/v3.5\ Update\ Combo/scripts/trap
echo 'source pkgtool' >> /root/Desktop/v3.5\ Update\ Combo/scripts/trap
exec bash --rcfile /root/Desktop/v3.5\ Update\ Combo/scripts/trap -i
exit
}
yumerror() {
kdialog --title "Failed To Install v3.5 Update Combo" --error "Failed to install necessary development tools via 'yum install'. \nPlease make sure the Red Star OS 3.5 installation image is inserted into the device and the built-in yum repo on the image can be accessed normally. \nIf you've already installed all components under the development category and do not need to repeat this process, just ignore this message. \n\nWe apologize for the disruption. \nClick 'OK' to continue... "
}
trap 'error' ERR
set +e
export PATH=/opt/Cross64/bin:$PATH
title() { printf '\033]0;%s\007' "$*" || return 1; }
nop() { return 0; }
Extract() {
set -x
set +e
if [[ -n "${3}" ]]; then
title "${3}" || return 1
else
title "Extracting ${1}" || return 1
fi
cd /workspace || return 1
tar xvf "/root/Desktop/v3.5 Update Combo/packages/${1}.tar.${2}" || return 1
cd "${1}" || return 1
return 0
}
CleanUp() {
set -x
set +e
if [[ -n "${2}" ]]; then
title "${2}"
else
title "Cleaning ${1}"
fi
cd /workspace || return 1
rm -rf "${1}" || return 1
return 0
}
InstallBase() {
set -x
set +e
local Package="${1}" || return 1
local Format="${2}" || return 1
local TitleText="${3}" || return 1
local Subfolder="${4}" || return 1
local ConfigureCommand="${5}" || return 1
local MakeCommand="${6}" || return 1
local DeployCommand="${7}" || return 1
local TitlePostfixA="${8}" || return 1
local TitlePostfixB="${9}" || return 1
local TitlePostfixC="${10}" || return 1
local TitlePostfixD="${11}" || return 1
local TitlePostfixE="${12}" || return 1
Extract "${Package}" "${Format}" "${TitleText} [${TitlePostfixA}]" || return 1
if [[ -n "${Subfolder}" ]]; then
mkdir "${Subfolder}" || return 1
cd "${Subfolder}" || return 1
fi
title "${TitleText} [${TitlePostfixB}]" || return 1
${ConfigureCommand} || return 1
title "${TitleText} [${TitlePostfixC}]" || return 1
${MakeCommand} || return 1
title "${TitleText} [${TitlePostfixD}]" || return 1
${DeployCommand}  || return 1
CleanUp "${Package}" "${TitleText} [${TitlePostfixE}]" || return 1
return 0
}
InstallEngine() {
set -x
set +e
local Package="${1}" || return 1
local Format="${2}" || return 1
local Thread="${3}" || return 1
local TitlePostfix="${4}" || return 1
shift 4 || return 1
local TitleText="Installing ${Package} ${TitlePostfix}" || return 1
local Subfolder="W0RK" || return 1
local ConfigureCommand="../configure ${@}" || return 1
local MakeCommand="make -j${Thread}" || return 1
local DeployCommand="make install" || return 1
InstallBase "${Package}" "${Format}" "${TitleText}" "${Subfolder}" "${ConfigureCommand}" "${MakeCommand}" "${DeployCommand}" 'Extracting' 'Configuring' 'Compiling' 'Deploying' 'Cleaning'
return 0
}
CustomInstall() {
set -x
set +e
local Package="${1}" || return 1
local Format="${2}" || return 1
local TitlePostfix="${3}" || return 1
local TitleText="Installing ${Package} ${TitlePostfix}" || return 1
local Subfolder="${4}" || return 1
local ConfigureCommand="${5}" || return 1
local MakeCommand="${6}" || return 1
local DeployCommand="${7}" || return 1
shift 7 || return 1
InstallBase "${Package}" "${Format}" "${TitleText}" "${Subfolder}" "${ConfigureCommand}" "${MakeCommand}" "${DeployCommand}" 'Extracting' 'Configuring' 'Compiling' 'Deploying' 'Cleaning'
return 0
}
Install() {
set -x
set +e
local Package="${1}" || return 1
local Format="${2}" || return 1
shift 2 || return 1
InstallEngine "${Package}" "${Format}" "$(grep -c ^processor /proc/cpuinfo)" "For Host" "--prefix=/usr" "${@}"
return 0
}
InstallJ1() {
set -x
set +e
local Package="${1}" || return 1
local Format="${2}" || return 1
shift 2 || return 1
InstallEngine "${Package}" "${Format}" '1' "For Host" "--prefix=/usr" "${@}"
return 0
}
InstallRoot() {
set -x
set +e
local Package="${1}" || return 1
local Format="${2}" || return 1
shift 2 || return 1
InstallEngine "${Package}" "${Format}" "$(grep -c ^processor /proc/cpuinfo)" "For Host" "--prefix=" "${@}"
return 0
}
InstallRootJ1() {
set -x
set +e
local Package="${1}" || return 1
local Format="${2}" || return 1
shift 2 || return 1
InstallEngine "${Package}" "${Format}" '1' "For Host" "--prefix=" "${@}"
return 0
}
InstallCross64() {
set -x
set +e
local Package="${1}" || return 1
local Format="${2}" || return 1
shift 2 || return 1
InstallEngine "${Package}" "${Format}" "$(grep -c ^processor /proc/cpuinfo)" "For Cross-x86_64" "--target=x86_64-linux-gnu --prefix=/opt/Cross64" "${@}"
return 0
}
InstallCross64J1() {
set -x
set +e
local Package="${1}" || return 1
local Format="${2}" || return 1
shift 2 || return 1
InstallEngine "${Package}" "${Format}" '1' "For Cross-x86_64" "--target=x86_64-linux-gnu --prefix=/opt/Cross64" "${@}"
return 0
}
Native64EnvSetup() {
export CROSS_PREFIX=/opt/Cross64 || return 1
export TARGET=x86_64-linux-gnu || return 1
export CC=${CROSS_PREFIX}/bin/${TARGET}-gcc || return 1
export GCC=${CROSS_PREFIX}/bin/${TARGET}-gcc || return 1
export CXX=${CROSS_PREFIX}/bin/${TARGET}-g++ || return 1
export GXX=${CROSS_PREFIX}/bin/${TARGET}-g++ || return 1
export CPP=${CROSS_PREFIX}/bin/${TARGET}-cpp || return 1
export CXXFILT=${CROSS_PREFIX}/bin/${TARGET}-c++filt || return 1
export AR=${CROSS_PREFIX}/bin/${TARGET}-ar || return 1
export AS=${CROSS_PREFIX}/bin/${TARGET}-as || return 1
export LD=${CROSS_PREFIX}/bin/${TARGET}-ld || return 1
export NM=${CROSS_PREFIX}/bin/${TARGET}-nm || return 1
export RANLIB=${CROSS_PREFIX}/bin/${TARGET}-ranlib || return 1
export STRIP=${CROSS_PREFIX}/bin/${TARGET}-strip || return 1
export STRINGS=${CROSS_PREFIX}/bin/${TARGET}-strings || return 1
export SIZE=${CROSS_PREFIX}/bin/${TARGET}-size || return 1
export OBJCOPY=${CROSS_PREFIX}/bin/${TARGET}-objcopy || return 1
export OBJDUMP=${CROSS_PREFIX}/bin/${TARGET}-objdump || return 1
export READELF=${CROSS_PREFIX}/bin/${TARGET}-readelf || return 1
export ELFEDIT=${CROSS_PREFIX}/bin/${TARGET}-elfedit || return 1
export DLLTOOL=${CROSS_PREFIX}/bin/${TARGET}-dlltool || return 1
export GCOV=${CROSS_PREFIX}/bin/${TARGET}-gcov || return 1
export GCOV_DUMP=${CROSS_PREFIX}/bin/${TARGET}-gcov-dump || return 1
export GCOV_TOOL=${CROSS_PREFIX}/bin/${TARGET}-gcov-tool || return 1
export GPROF=${CROSS_PREFIX}/bin/${TARGET}-gprof || return 1
export ADDR2LINE=${CROSS_PREFIX}/bin/${TARGET}-addr2line || return 1
$CC --help || return 1
$GCC --help || return 1
$CXX --help || return 1
$GXX --help || return 1
$CPP --help || return 1
$CXXFILT --help || return 1
$AR --help || return 1
$AS --help || return 1
$LD --help || return 1
$NM --help || return 1
$RANLIB --help || return 1
$STRIP --help || return 1
$STRINGS --help || return 1
$SIZE --help || return 1
$OBJCOPY --help || return 1
$OBJDUMP --help || return 1
$READELF --help || return 1
$ELFEDIT --help || return 1
$DLLTOOL --help || return 1
$GCOV --help || return 1
$GCOV_DUMP --help || return 1
$GCOV_TOOL --help || return 1
$GPROF --help || return 1
$ADDR2LINE --help || return 1
return 0
}
Native64EnvCleanUp() {
unset CROSS_PREFIX || return 1
unset TARGET || return 1
unset CC || return 1
unset GCC || return 1
unset CXX || return 1
unset GXX || return 1
unset CPP || return 1
unset CXXFILT || return 1
unset AR || return 1
unset AS || return 1
unset LD || return 1
unset NM || return 1
unset RANLIB || return 1
unset STRIP || return 1
unset STRINGS || return 1
unset SIZE || return 1
unset OBJCOPY || return 1
unset OBJDUMP || return 1
unset READELF || return 1
unset ELFEDIT || return 1
unset DLLTOOL || return 1
unset GCOV || return 1
unset GCOV_DUMP || return 1
unset GCOV_TOOL || return 1
unset GPROF || return 1
unset ADDR2LINE || return 1
return 0
}
InstallNative64() {
set -x
set +e
local Package="${1}" || return 1
local Format="${2}" || return 1
shift 2 || return 1
Native64EnvSetup
InstallEngine "${Package}" "${Format}" "$(grep -c ^processor /proc/cpuinfo)" "For Host-x64" "--target=x86_64-linux-gnu --prefix=/usr --with-sysroot=/opt/Cross64/x86_64-linux-gnu --with-build-sysroot=/opt/Cross64/x86_64-linux-gnu --includedir=/opt/Cross64/x86_64-linux-gnu/include" "${@}"
Native64EnvCleanUp
return 0
}
InstallNative64J1() {
set -x
set +e
local Package="${1}" || return 1
local Format="${2}" || return 1
shift 2 || return 1
Native64EnvSetup
InstallEngine "${Package}" "${Format}" '1' "For Host-x64" "--target=x86_64-linux-gnu --prefix=/usr --with-sysroot=/opt/Cross64/x86_64-linux-gnu --with-build-sysroot=/opt/Cross64/x86_64-linux-gnu --includedir=/opt/Cross64/x86_64-linux-gnu/include" "${@}"
Native64EnvCleanUp
return 0
}
InstallNative64Root() {
set -x
set +e
local Package="${1}" || return 1
local Format="${2}" || return 1
shift 2 || return 1
Native64EnvSetup
InstallEngine "${Package}" "${Format}" "$(grep -c ^processor /proc/cpuinfo)" "For Host-x64" "--target=x86_64-linux-gnu --prefix= --with-sysroot=/opt/Cross64/x86_64-linux-gnu --with-build-sysroot=/opt/Cross64/x86_64-linux-gnu --includedir=/opt/Cross64/x86_64-linux-gnu/include" "${@}"
Native64EnvCleanUp
return 0
}
InstallNative64RootJ1() {
set -x
set +e
local Package="${1}" || return 1
local Format="${2}" || return 1
shift 2 || return 1
Native64EnvSetup
InstallEngine "${Package}" "${Format}" '1' "For Host-x64" "--target=x86_64-linux-gnu --prefix= --with-sysroot=/opt/Cross64/x86_64-linux-gnu --with-build-sysroot=/opt/Cross64/x86_64-linux-gnu --includedir=/opt/Cross64/x86_64-linux-gnu/include" "${@}"
Native64EnvCleanUp
return 0
}
RemoveEngine() {
set -x
set +e
local Package="${1}" || return 1
local Format="${2}" || return 1
local TitlePostfix="${3}" || return 1
shift 3 || return 1
local TitleText="Removing ${Package} ${TitlePostfix}" || return 1
local Subfolder="W0RK" || return 1
local ConfigureCommand="../configure ${@}" || return 1
local MakeCommand="nop" || return 1
local DeployCommand="make uninstall" || return 1
InstallBase "${Package}" "${Format}" "${TitleText}" "${Subfolder}" "${ConfigureCommand}" "${MakeCommand}" "${DeployCommand}" 'Extracting' 'Configuring' 'Compiling' 'Erasing' 'Cleaning'
return 0
}
Remove() {
set -x
set +e
local Package="${1}" || return 1
local Format="${2}" || return 1
shift 2 || return 1
RemoveEngine "${Package}" "${Format}" "For Host"  "--prefix=/usr" "${@}"
return 0
}
RemoveRoot() {
set -x
set +e
local Package="${1}" || return 1
local Format="${2}" || return 1
shift 2 || return 1
RemoveEngine "${Package}" "${Format}" "For Host" "--prefix=" "${@}"
return 0
}
RemoveCross64() {
set -x
set +e
local Package="${1}" || return 1
local Format="${2}" || return 1
shift 2 || return 1
RemoveEngine "${Package}" "${Format}" "For Cross-x86_64" "--target=x86_64-linux-gnu --prefix=/opt/Cross64" "${@}"
return 0
}
RemoveNative64() {
set -x
set +e
local Package="${1}" || return 1
local Format="${2}" || return 1
shift 2 || return 1
Native64EnvSetup
RemoveEngine "${Package}" "${Format}" "For Host-x64" "--target=x86_64-linux-gnu --prefix= --with-sysroot=/opt/Cross64/x86_64-linux-gnu --with-build-sysroot=/opt/Cross64/x86_64-linux-gnu --includedir=/opt/Cross64/x86_64-linux-gnu/include" "${@}"
Native64EnvCleanUp
return 0
}
Check() {
set -x
set +e
local Package="${1}" || return 1
local Format="${2}" || return 1
shift 2 || return 1
local TitleText="Checking ${Package}" || return 1
local Subfolder="W0RK" || return 1
local ConfigureCommand="../configure ${@} --help" || return 1
local MakeCommand="nop" || return 1
local DeployCommand="nop" || return 1
InstallBase "${Package}" "${Format}" "${TitleText}" "${Subfolder}" "${ConfigureCommand}" "${MakeCommand}" "${DeployCommand}" 'Extracting' 'Configuring' 'Compiling' 'Deploying' 'Cleaning'
return 0
}
KernelInstall() {
set -x
set +e
local Package="${1}" || return 1
local Format="${2}" || return 1
local TitleText="Installing Kernel ${Package}" || return 1
local ConfigureCommand="make allyesconfig" || return 1
local MakeCommand="make -j$(grep -c ^processor /proc/cpuinfo)" || return 1
local DeployCommandA="make modules_install" || return 1
local DeployCommandB="make install" || return 1
local DeployCommandC="make headers_install INSTALL_HDR_PATH=/usr/include" || return 1
local TitlePostfixA="Extracting" || return 1
local TitlePostfixB="Configuring" || return 1
local TitlePostfixC="Compiling" || return 1
local TitlePostfixD="Deploying Modules" || return 1
local TitlePostfixE="Deploying Ramfs & vmlinuz" || return 1
local TitlePostfixF="Deploying Headers" || return 1
title "${TitleText} [${TitlePostfixA}]" || return 1
cd /usr/src/kernels || return 1
tar xvf "/root/Desktop/v3.5 Update Combo/packages/${Package}.tar.${Format}" || return 1
cd "${Package}" || return 1
title "${TitleText} [${TitlePostfixB}]" || return 1
${ConfigureCommand} || return 1
title "${TitleText} [${TitlePostfixC}]" || return 1
${MakeCommand} || return 1
title "${TitleText} [${TitlePostfixD}]" || return 1
${DeployCommandA}  || return 1
title "${TitleText} [${TitlePostfixE}]" || return 1
${DeployCommandB}  || return 1
title "${TitleText} [${TitlePostfixF}]" || return 1
${DeployCommandC}  || return 1
sed -i 's/^default=[0-9]\+/default=0/' '/boot/grub/grub.conf' || return 1
cd /workspace || return 1
return 0
}
