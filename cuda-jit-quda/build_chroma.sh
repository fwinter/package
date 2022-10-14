source ./env.sh
pushd ${BUILDROOT}

if [ -d ./build_chroma ];
then
  rm -rf ./build_chroma
fi

mkdir  ./build_chroma
cd ./build_chroma

cmake ${SRCROOT}/chroma \
      -DCMAKE_BUILD_TYPE=Release \
      -DQDPXX_DIR=${INSTALLROOT}/qdpxx/lib/cmake/QDPXX \
      -DQMP_DIR=${INSTALLROOT}/qmp/lib/cmake/QMP \
      -DLLVM_DIR=${INSTALLROOT}/llvm-14/lib/cmake/llvm \
      -DChroma_ENABLE_JIT_CLOVER=ON \
      -DChroma_ENABLE_QUDA=ON \
      -DQUDA_DIR=${INSTALLROOT}/quda/lib/cmake/QUDA \
      -DCMAKE_INSTALL_PREFIX=${INSTALLROOT}/chroma

make -j 8
make install


popd
