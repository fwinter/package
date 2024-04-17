source ./env.sh
pushd ${BUILDROOT}

if [ -d ./build_chroma ];
then
  rm -rf ./build_chroma
fi

#      -DLLVM_DIR=${INSTALLROOT}/llvm-13/lib/cmake/llvm \
#      -DChroma_ENABLE_LAPACK=ON \
#      -DLLD_DIR=${ROCM_PATH}/llvm/lib/cmake/lld \

mkdir  ./build_chroma
cd ./build_chroma
cmake ${SRCROOT}/chroma \
      -DQDPXX_DIR=${INSTALLROOT}/qdpxx/lib/cmake/QDPXX \
      -DQMP_DIR=${INSTALLROOT}/qmp/lib/cmake/QMP \
      -DLLVM_DIR=${INSTALLROOT}/llvm-17/lib/cmake/llvm \
      -DLLD_DIR=${INSTALLROOT}/llvm-17/lib/cmake/lld \
      -DChroma_ENABLE_JIT_CLOVER=ON \
      -DCMAKE_INSTALL_PREFIX=${INSTALLROOT}/chroma

make -j 32
make install


popd
