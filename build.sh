#!/bin/bash
# Authors: KunYi <kunyi.chen@gmail.com>
# ref.
#     [RTEMS 5.1 release documents](https://ftp.rtems.org/pub/rtems/releases/5/5.1/)
#     [RTEMS 5.1 User Manual](https://ftp.rtems.org/pub/rtems/releases/5/5.1/docs/html/user)
set -x

[ ! -d "${HOME}/development/rtems" ] && mkdir -p ${HOME}/development/rtems && \
cd ${HOME}/development/rtems

# download rtems source builder 5.1
[[ ! -f "${HOME}/development/rtems/rtems-source-builder-5.1.tar.xz" ]] && \
wget https://ftp.rtems.org/pub/rtems/releases/5/5.1/sources/rtems-source-builder-5.1.tar.xz && \
tar Jxf rtems-source-builder-5.1.tar.xz && \
echo "finish download & extrace source builder"


# To build the tools for the ARM architecture
[ -d "${HOME}/development/rtems/rtems-source-builder-5.1/rtems" ] && \
cd ${HOME}/development/rtems/rtems-source-builder-5.1/rtems && \
../source-builder/sb-set-builder \
    --prefix=${HOME}/development/rtems/5.1 \
    5/rtems-arm && \
echo "complete build ARM architecture tools"

# To build the tools, kernel and all packages for the Beagleboneblack
../source-builder/sb-set-builder \
    --prefix=${HOME}/development/rtems/5.1 \
    5/bsps/beagleboneblack && \
echo "complete build tools, kernel, libraries for beaglebbone black  "

# To clone rtems kernel repository
[ ! -d "${HOME}/development/rtems/kernel" ] && mkdir -p ${HOME}/development/rtems/kernel && \
cd ${HOME}/development/rtems/kernel && \
git clone git://git.rtems.org/rtems.git rtems && \
cd rtems && \
git checkout 5.1 -b 5.1
