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

L0=$(whichlib libze_loader.so |& sed "s+lib64.*++" | head -n 1)
echo ${L0}


cmake ${SRCROOT}/qdp-jit \
      -DLevelZero_INCLUDE_DIR=${L0}/include \
      -DLevelZero_LIBRARY=${L0}/lib64 \
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
