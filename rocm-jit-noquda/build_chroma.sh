source ./env.sh
pushd ${BUILDROOT}

if [ -d ./build_chroma ];
then
  rm -rf ./build_chroma
fi

#      -DLLVM_DIR=${INSTALLROOT}/llvm-13/lib/cmake/llvm \
#      -DChroma_ENABLE_LAPACK=ON \

mkdir  ./build_chroma
cd ./build_chroma
cmake ${SRCROOT}/chroma \
      -DQDPXX_DIR=${INSTALLROOT}/qdpxx/lib/cmake/QDPXX \
      -DQMP_DIR=${INSTALLROOT}/qmp/lib/cmake/QMP \
      -DLLD_DIR=${ROCM_PATH}/llvm/lib/cmake/lld \
      -DChroma_ENABLE_JIT_CLOVER=ON \
      -DCMAKE_INSTALL_PREFIX=${INSTALLROOT}/chroma

make -j 32
make install


popd
