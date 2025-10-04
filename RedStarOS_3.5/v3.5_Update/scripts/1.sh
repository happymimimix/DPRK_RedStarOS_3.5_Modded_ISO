#!/bin/bash
kdialog --title "Install v3.5 Update Combo" --error "This tool will guide you through the installation process of the unofficial v3.5 update for Red Star OS 3.0. \n\nThis will upgrade the system kernel to 5.4 x86_64 along with updates to many other critical system components and libraries. \n\nThe process is fully automatic, do not touch anything except typing your login password when asked. \nYour device will reboot for a couple of times during the process, it's recommended to set up automatic login in \"System Preferences -> Accounts -> Login Options -> Automatic Login\" so the amount of times the password need to be typed can be reduced. \n\nClick 'OK' when ready... "
set -x
killall -9 -e artsd
source '/root/Desktop/v3.5 Update Combo/scripts/pkgutils.sh'
trap 'scripterror' ERR
set +e
MakeShortcut
WorkspaceCleanUp
trap 'yumerror' ERR
set +e
yum install @"Development Tools" "kernel*" -y -x "*PAE*"
trap 'scripterror' ERR
set +e
Install bc-1.07.1 gz --enable-shared
Install make-4.2.1 gz --with-libintl-prefix --with-libiconv-prefix --with-gnu-ld
Install gmp-4.3.2 bz2 --enable-cxx --enable-shared
Install mpfr-2.4.2 bz2 --enable-shared
Install mpc-0.8.1 gz --enable-shared
Install isl-0.14 bz2
Install zlib-1.2.11 xz
InstallRoot zlib-1.2.11 xz
Install gcc-6.5.0 xz --mandir=/usr/share/man --infodir=/usr/share/info \
--enable-ld=yes --enable-gold=no --enable-obsolete \
--enable-threads=posix --enable-checking=release --with-system-zlib \
--enable-__cxa_atexit --disable-libunwind-exceptions --with-tune=generic \
--enable-languages=ada,c,c++,fortran,go,java,jit,lto,objc,obj-c++ \
--enable-shared --enable-host-shared \
--enable-lto --enable-tls --enable-libada --enable-libsanitizer --enable-libssp \
--enable-libquadmath --enable-libquadmath-support --enable-libgomp --enable-libvtv \
--enable-libgcj --enable-static-libjava=unicows --enable-objc-gc --enable-vtable-verify
Install gdb-7.12 xz --mandir=/usr/share/man --infodir=/usr/share/info \
--enable-ld=yes --enable-gold=no --enable-obsolete \
--enable-threads=posix --enable-checking=release --with-system-zlib \
--enable-__cxa_atexit --disable-libunwind-exceptions --with-tune=generic \
--enable-shared --enable-host-shared \
--enable-lto --enable-tls --enable-libada --enable-libsanitizer --enable-libssp \
--enable-libquadmath --enable-libquadmath-support --enable-libgomp --enable-libvtv \
--enable-libgcj --enable-static-libjava=unicows --enable-objc-gc --enable-vtable-verify
Install binutils-2.34 xz --mandir=/usr/share/man --infodir=/usr/share/info \
--enable-ld=yes --enable-gold=no --enable-obsolete \
--enable-threads=posix --enable-checking=release --with-system-zlib \
--enable-__cxa_atexit --disable-libunwind-exceptions --with-tune=generic \
--enable-shared --enable-host-shared \
--enable-lto --enable-tls --enable-libada --enable-libsanitizer --enable-libssp \
--enable-libquadmath --enable-libquadmath-support --enable-libgomp --enable-libvtv \
--enable-libgcj --enable-static-libjava=unicows --enable-objc-gc --enable-vtable-verify
Install ncurses-6.0 gz --with-ada --enable-ext-colors --enable-ext-mouse
Install gmp-6.2.1 bz2 --enable-cxx --enable-shared
Install mpfr-4.1.0 bz2 --enable-shared
Install mpc-1.2.1 gz --enable-shared
Install isl-0.24 bz2
Install nettle-3.4.1 gz --enable-shared --enable-threads
Install libtasn1-4.10 gz
Install libunistring-1.1 gz
Install libiconv-1.16 gz
Install cpio-2.13 gz
CustomInstall openssl-1.0.2u gz "For Host" "" \
"./config --openssldir=/usr/ssl" \
"make all -j$(grep -c ^processor /proc/cpuinfo)" \
"make install"
Install expat-2.2.10 xz
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
Install Python-3.7.6 xz --enable-optimizations --with-pydebug
Cross64CleanUp
InstallCross64 binutils-2.34 xz --mandir=/opt/Cross64/x86_64-pc-linux-gnu/share/man --infodir=/opt/Cross64/x86_64-pc-linux-gnu/share/info \
--enable-ld=yes --enable-gold=no --enable-obsolete \
--enable-threads=posix --enable-checking=release --with-system-zlib \
--enable-__cxa_atexit --disable-libunwind-exceptions --with-tune=generic \
--enable-shared --enable-host-shared \
--enable-lto --enable-tls --enable-libada --enable-libsanitizer --enable-libssp \
--enable-libquadmath --enable-libquadmath-support --enable-libgomp --enable-libvtv \
--enable-libgcj --enable-static-libjava=unicows --enable-objc-gc --enable-vtable-verify
cp -rnv /opt/Cross64/i686-pc-linux-gnu/x86_64-pc-linux-gnu/* /opt/Cross64/x86_64-pc-linux-gnu/
CustomInstall gcc-6.5.0 xz "For Cross-x86_64 (Bootstrap Stage 1)" "W0RK" \
"../configure --target=x86_64-pc-linux-gnu --prefix=/opt/Cross64 --without-headers \
--mandir=/opt/Cross64/x86_64-pc-linux-gnu/share/man --infodir=/opt/Cross64/x86_64-pc-linux-gnu/share/info \
--enable-ld=yes --enable-gold=no --enable-obsolete \
--enable-threads=posix --enable-checking=release --enable-bootstrap \
--enable-__cxa_atexit --disable-libunwind-exceptions --with-tune=generic \
--enable-languages=c,c++,objc,obj-c++ \
--enable-shared --enable-host-shared" \
"make all-gcc -j$(grep -c ^processor /proc/cpuinfo)" \
"make install-gcc"
title Installing Kernel 3.19.8 For Cross-x86_64 \[Extracting\]
cd /usr/src/kernels
tar xvf "/root/Desktop/v3.5 Update Combo/packages/linux-3.19.8.tar.xz"
cd /usr/src/kernels/linux-3.19.8
title Installing Kernel 3.19.8 For Cross-x86_64 \[Deploying Headers\]
make headers_install ARCH=x86_64 INSTALL_HDR_PATH=/opt/Cross64/x86_64-pc-linux-gnu
CustomInstall glibc-2.23 xz "For Cross-x86_64 (Bootstrap Stage 1)" "W0RK" \
"../configure --prefix=/opt/Cross64 --mandir=/opt/Cross64/x86_64-pc-linux-gnu/share/man --infodir=/opt/Cross64/x86_64-pc-linux-gnu/share/info \
--host=x86_64-pc-linux-gnu --build=i386-pc-linux-gnu --with-sysroot=/opt/Cross64/x86_64-pc-linux-gnu \
--with-headers=/opt/Cross64/x86_64-pc-linux-gnu/include --includedir=/opt/Cross64/x86_64-pc-linux-gnu/include \
--enable-shared --enable-profile --enable-obsolete-rpc --disable-werror" \
"nop" \
"make install-headers install-bootstrap-headers=yes"
CustomInstall glibc-2.23 xz "For Cross-x86_64 (Bootstrap Stage 2)" "W0RK" \
"../configure --prefix=/opt/Cross64/x86_64-pc-linux-gnu --mandir=/opt/Cross64/x86_64-pc-linux-gnu/share/man --infodir=/opt/Cross64/x86_64-pc-linux-gnu/share/info \
--host=x86_64-pc-linux-gnu --build=i386-pc-linux-gnu --with-sysroot=/opt/Cross64/x86_64-pc-linux-gnu \
--with-headers=/opt/Cross64/x86_64-pc-linux-gnu/include --includedir=/opt/Cross64/x86_64-pc-linux-gnu/include \
--enable-shared --enable-profile --enable-obsolete-rpc --disable-werror" \
"make csu/subdir_lib -j$(grep -c ^processor /proc/cpuinfo)" \
"install csu/crt1.o csu/crti.o csu/crtn.o /opt/Cross64/x86_64-pc-linux-gnu/lib"
touch /opt/Cross64/x86_64-pc-linux-gnu/include/gnu/stubs.h
rm -f '/opt/Cross64/x86_64-pc-linux-gnu/usr'
ln -sdf '/opt/Cross64/x86_64-pc-linux-gnu/' '/opt/Cross64/x86_64-pc-linux-gnu/usr'
CustomInstall gcc-6.5.0 xz "For Cross-x86_64 (Bootstrap Stage 3)" "W0RK" \
"../configure --target=x86_64-pc-linux-gnu --prefix=/opt/Cross64 \
--mandir=/opt/Cross64/x86_64-pc-linux-gnu/share/man --infodir=/opt/Cross64/x86_64-pc-linux-gnu/share/info \
--with-sysroot=/opt/Cross64/x86_64-pc-linux-gnu --with-headers=/opt/Cross64/x86_64-pc-linux-gnu/include --includedir=/opt/Cross64/x86_64-pc-linux-gnu/include \
--enable-ld=yes --enable-gold=no --enable-obsolete \
--enable-threads=posix --enable-checking=release \
--enable-__cxa_atexit --disable-libunwind-exceptions --with-tune=generic \
--enable-languages=c,c++,objc,obj-c++ \
--disable-shared --enable-host-shared" \
"make all-target-libgcc -j$(grep -c ^processor /proc/cpuinfo)" \
"make install-target-libgcc"
CustomInstall gcc-6.5.0 xz "For Cross-x86_64 (Bootstrap Stage 4)" "W0RK" \
"sed -i 's/as_fn_error \"Link tests are not allowed after GCC_NO_EXECUTABLES.\" \"\$LINENO\" 5/as_fn_error \"Link tests are not allowed after GCC_NO_EXECUTABLES.\" \"\$LINENO\" 0/g' /workspace/gcc-6.5.0/libssp/configure; \
sed -zi 's/as_fn_error \"C compiler cannot create executables\\nSee \\\\\`config.log'\\'' for more details.\" \"\$LINENO\" 5/as_fn_error \"C compiler cannot create executables\\nSee \\\\\`config.log'\\'' for more details.\" \"\$LINENO\" 0/g' /workspace/gcc-6.5.0/libgomp/configure; \
../configure --target=x86_64-pc-linux-gnu --prefix=/opt/Cross64 \
--mandir=/opt/Cross64/x86_64-pc-linux-gnu/share/man --infodir=/opt/Cross64/x86_64-pc-linux-gnu/share/info \
--with-sysroot=/opt/Cross64/x86_64-pc-linux-gnu --with-headers=/opt/Cross64/x86_64-pc-linux-gnu/include --includedir=/opt/Cross64/x86_64-pc-linux-gnu/include \
--enable-ld=yes --enable-gold=no --enable-obsolete \
--enable-threads=posix --enable-checking=release \
--enable-__cxa_atexit --disable-libunwind-exceptions --with-tune=generic \
--enable-languages=c,c++,objc,obj-c++ \
--disable-shared --enable-host-shared \
--enable-lto --enable-tls --enable-libada --enable-libsanitizer --enable-libssp \
--enable-libquadmath --enable-libquadmath-support --enable-libgomp --enable-libvtv \
--enable-libgcj --enable-static-libjava=unicows --enable-objc-gc --enable-vtable-verify" \
"make all-target -j$(grep -c ^processor /proc/cpuinfo)" \
"make install-target"
export CFLAGS="-O2 -g -fno-common"
export CXXFLAGS="-O2 -g -fno-common"
CustomInstall glibc-2.23 xz "For Cross-x86_64" "W0RK" \
"../configure --prefix=/opt/Cross64 --mandir=/opt/Cross64/x86_64-pc-linux-gnu/share/man --infodir=/opt/Cross64/x86_64-pc-linux-gnu/share/info \
--host=x86_64-pc-linux-gnu --build=i386-pc-linux-gnu --with-sysroot=/opt/Cross64/x86_64-pc-linux-gnu \
--with-headers=/opt/Cross64/x86_64-pc-linux-gnu/include --includedir=/opt/Cross64/x86_64-pc-linux-gnu/include \
--enable-shared --enable-profile --enable-obsolete-rpc --disable-werror" \
"make all -j$(grep -c ^processor /proc/cpuinfo)" \
"make install"
unset CFLAGS
unset CXXFLAGS
InstallCross64 gcc-6.5.0 xz --mandir=/opt/Cross64/x86_64-pc-linux-gnu/share/man --infodir=/opt/Cross64/x86_64-pc-linux-gnu/share/info \
--with-sysroot=/opt/Cross64/x86_64-pc-linux-gnu --with-headers=/opt/Cross64/x86_64-pc-linux-gnu/include --includedir=/opt/Cross64/x86_64-pc-linux-gnu/include \
--enable-ld=yes --enable-gold=no --enable-obsolete \
--enable-threads=posix --enable-checking=release --with-system-zlib \
--enable-__cxa_atexit --disable-libunwind-exceptions --with-tune=generic \
--enable-languages=ada,c,c++,fortran,go,java,jit,lto,objc,obj-c++ \
--enable-shared --enable-host-shared \
--enable-lto --enable-tls --enable-libada --enable-libsanitizer --enable-libssp \
--enable-libquadmath --enable-libquadmath-support --enable-libgomp --enable-libvtv \
--enable-libgcj --enable-static-libjava=unicows --enable-objc-gc --enable-vtable-verify
bash
KernelInstall 3.19.8 gz
EnterStage 2
