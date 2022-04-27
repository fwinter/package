#!/bin/bash

source ./env.sh


pushd ${BUILDROOT}

if [ -d ./build_llvm_13 ]; 
then 
  rm -rf ./build_llvm_13
fi


mkdir  ./build_llvm_13
pushd ./build_llvm_13


#      -DLLVM_ENABLE_RTTI="ON"


cmake ${SRCROOT}/llvm-13.0.1.src \
      -DCMAKE_CXX_COMPILER="g++" \
      -DCMAKE_C_COMPILER="gcc" \
      -DLLVM_ENABLE_TERMINFO="OFF" \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX=${INSTALLROOT}/llvm-13  \
      -DLLVM_TARGETS_TO_BUILD="NVPTX" \
      -DLLVM_ENABLE_ZLIB="OFF" \
      -DBUILD_SHARED_LIBS="ON"



make -j 32
make install

popd
