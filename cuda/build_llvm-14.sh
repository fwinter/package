#!/bin/bash

source ./env.sh


pushd ${BUILDROOT}

if [ -d ./build_llvm_14 ]; 
then 
  rm -rf ./build_llvm_14
fi


mkdir  ./build_llvm_14
pushd ./build_llvm_14


#      -DLLVM_ENABLE_RTTI="ON"


cmake ${SRCROOT}/llvm-project-14.0.6.src/llvm \
      -DLLVM_ENABLE_PROJECTS="llvm" \
      -DCMAKE_CXX_COMPILER="g++" \
      -DCMAKE_C_COMPILER="gcc" \
      -DLLVM_ENABLE_TERMINFO="OFF" \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX=${INSTALLROOT}/llvm-14  \
      -DLLVM_TARGETS_TO_BUILD="NVPTX" \
      -DLLVM_ENABLE_ZLIB="OFF" \
      -DBUILD_SHARED_LIBS="ON"



make -j 8
make install

popd
