source ./env.sh
pushd ${BUILDROOT}

if [ -d ./build_qdpxx ];
then
    echo "Removing previous QDP"
    rm -rf ./build_qdpxx
fi

mkdir  ./build_qdpxx
cd ./build_qdpxx


export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:${INSTALLROOT}/translator/lib/pkgconfig"

L0_INC=$(pkg-config --variable=includedir level-zero)
L0_LIB=$(pkg-config --variable=libdir level-zero)
echo "Level Zero: include=${L0_INC} lib=${L0_LIB}"


cmake ${SRCROOT}/qdp-jit \
      -DCMAKE_INCLUDE_PATH=${L0_INC} \
      -DCMAKE_LIBRARY_PATH=${L0_LIB} \
      -DCMAKE_BUILD_TYPE=Release \
      -DQDP_PRECISION=double \
      -DCMAKE_INSTALL_PREFIX=${INSTALLROOT}/qdpxx \
      -DQMP_DIR=${INSTALLROOT}/qmp/lib/cmake/QMP \
      -DLLVM_DIR=${INSTALLROOT}/llvm-22/lib/cmake/llvm \
      -DQDP_ENABLE_BACKEND=L0 \
      -DQDP_BUILD_EXAMPLES=ON \
      -DQDP_ENABLE_LLVM22=ON


make -j 8
make install

popd
