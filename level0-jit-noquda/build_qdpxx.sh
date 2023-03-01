source ./env.sh
pushd ${BUILDROOT}

if [ -d ./build_qdpxx ];
then
    echo "Removing previous QDP"
    rm -rf ./build_qdpxx
fi

mkdir  ./build_qdpxx
cd ./build_qdpxx


if [ -z $PKG_PROP_OPT ]
then
    PKG_PROP_OPT="ON"
elif [ $PKG_PROP_OPT != "OFF" ]
then
    PKG_PROP_OPT="ON"
fi

#       -DQDP_ENABLE_COMM_SPLIT_DEVICEINIT=ON
#       -DLLVM_DIR=${INSTALLROOT}/llvm-13/lib/cmake/llvm \
#       -DQDP_LAYOUT="cb2" \
#       -DQDP_LAYOUT="vnode" \
#      -DCMAKE_BUILD_TYPE=Debug \

export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:${INSTALLROOT}/translator/lib/pkgconfig"


L0=$(whichlib libze_loader.so |& sed "s+lib64.*++" | head -n 1)
echo ${L0}


cmake ${SRCROOT}/qdp-jit \
      -DLevelZero_INCLUDE_DIR=${L0}/include \
      -DLevelZero_LIBRARY=${L0}/lib64 \
      -DQDP_ENABLE_MANAGED_MEMORY=OFF \
      -DCMAKE_BUILD_TYPE=Release \
      -DQDP_ENABLE_DEEP_LOG=OFF \
      -DQDP_PRECISION=double \
      -DCMAKE_INSTALL_PREFIX=${INSTALLROOT}/qdpxx \
      -DQMP_DIR=${INSTALLROOT}/qmp/lib/cmake/QMP \
      -DLLVM_DIR=${INSTALLROOT}/llvm-13/lib/cmake/llvm \
      -DQDP_ENABLE_BACKEND=L0 \
      -DQDP_LAYOUT="cb2" \
      -DQDP_ENABLE_CODEGEN_VECTOR=OFF \
      -DQDP_BUILD_EXAMPLES=ON \
      -DQDP_ENABLE_LLVM14=OFF \
      -DQDP_PROP_OPT=$PKG_PROP_OPT


make -j 8
make install

popd
