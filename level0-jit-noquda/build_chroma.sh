source ./env.sh
pushd ${BUILDROOT}

if [ -d ./build_chroma ];
then
    echo "Removing previous Chroma"
    rm -rf ./build_chroma
fi



L0=$(whichlib libze_loader.so |& sed "s+lib64.*++" | head -n 1)

export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:${INSTALLROOT}/translator/lib/pkgconfig"


mkdir  ./build_chroma
cd ./build_chroma
cmake ${SRCROOT}/chroma \
      -DLevelZero_INCLUDE_DIR=${L0}/include \
      -DLevelZero_LIBRARY=${L0}/lib64 \
      -DCMAKE_BUILD_TYPE=Debug \
      -DQDPXX_DIR=${INSTALLROOT}/qdpxx/lib/cmake/QDPXX \
      -DQMP_DIR=${INSTALLROOT}/qmp/lib/cmake/QMP \
      -DChroma_ENABLE_JIT_CLOVER=ON \
      -DLLVM_DIR=${INSTALLROOT}/llvm-13/lib/cmake/llvm \
      -DCMAKE_INSTALL_PREFIX=${INSTALLROOT}/chroma

make -j 32
make install


popd
