source ./env.sh
pushd ${BUILDROOT}

if [ -d ./build_chroma ];
then
    echo "Removing previous Chroma"
    rm -rf ./build_chroma
fi

#      -DLLVM_DIR=${INSTALLROOT}/llvm-13/lib/cmake/llvm \
#      -DChroma_ENABLE_LAPACK=ON \
#      -DCMAKE_BUILD_TYPE=Debug \

export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:${INSTALLROOT}/translator/lib/pkgconfig:${INSTALLROOT}/level-zero/lib64/pkgconfig"

mkdir  ./build_chroma
cd ./build_chroma
cmake ${SRCROOT}/chroma \
      -DQDPXX_DIR=${INSTALLROOT}/qdpxx/lib/cmake/QDPXX \
      -DQMP_DIR=${INSTALLROOT}/qmp/lib/cmake/QMP \
      -DChroma_ENABLE_JIT_CLOVER=ON \
      -DLLVM_DIR=${INSTALLROOT}/llvm-13/lib/cmake/llvm \
      -DCMAKE_INSTALL_PREFIX=${INSTALLROOT}/chroma

make -j 8
make install


popd
