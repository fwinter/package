source ./env.sh
pushd ${BUILDROOT}

if [ -d ./build_chroma ];
then
    echo "Removing previous Chroma"
    rm -rf ./build_chroma
fi


export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:${INSTALLROOT}/translator/lib/pkgconfig"

L0_INC=$(pkg-config --variable=includedir level-zero)
L0_LIB=$(pkg-config --variable=libdir level-zero)
echo "Level Zero: include=${L0_INC} lib=${L0_LIB}"


mkdir  ./build_chroma
cd ./build_chroma
cmake ${SRCROOT}/chroma \
      -DCMAKE_BUILD_TYPE=Release \
      -DQDPXX_DIR=${INSTALLROOT}/qdpxx/lib/cmake/QDPXX \
      -DQMP_DIR=${INSTALLROOT}/qmp/lib/cmake/QMP \
      -DChroma_ENABLE_JIT_CLOVER=ON \
      -DLLVM_DIR=${INSTALLROOT}/llvm-22/lib/cmake/llvm \
      -DCMAKE_INSTALL_PREFIX=${INSTALLROOT}/chroma

make -j 32
make install


popd
