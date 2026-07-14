#!/bin/bash

source ./env.sh


pushd ${BUILDROOT}

if [ -d ./build_llvm_22 ]; 
then 
  rm -rf ./build_llvm_22
fi


mkdir  ./build_llvm_22
pushd ./build_llvm_22


#      -DLLVM_ENABLE_RTTI="ON"


cmake ${SRCROOT}/llvm-project-22.1.0.src/llvm \
      -DLLVM_ENABLE_PROJECTS="llvm" \
      -DCMAKE_CXX_COMPILER="g++" \
      -DCMAKE_C_COMPILER="gcc" \
      -DLLVM_ENABLE_TERMINFO="OFF" \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX=${INSTALLROOT}/llvm-22  \
      -DLLVM_TARGETS_TO_BUILD="AMDGPU" \
      -DLLVM_ENABLE_ZLIB="OFF" \
      -DBUILD_SHARED_LIBS="ON"


make -j 8
make install

popd
