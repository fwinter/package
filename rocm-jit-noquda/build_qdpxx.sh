source ./env.sh
pushd ${BUILDROOT}

if [ -d ./build_qdpxx ];
then
  rm -rf ./build_qdpxx
fi

mkdir  ./build_qdpxx
cd ./build_qdpxx

#       -DQDP_ENABLE_COMM_SPLIT_DEVICEINIT=ON

if [ -z $PKG_PROP_OPT ]
then
    PKG_PROP_OPT="ON"
elif [ $PKG_PROP_OPT != "OFF" ]
then
    PKG_PROP_OPT="ON"
fi


cmake ${SRCROOT}/qdp-jit \
      -DCMAKE_BUILD_TYPE=Release \
      -DQDP_PRECISION=double \
      -DQDP_ROCM5FIX=OFF \
      -DQDP_ROCM553FIX=OFF \
      -DQDP_ROCM_PRE=OFF \
      -DCMAKE_INSTALL_PREFIX=${INSTALLROOT}/qdpxx \
      -DQMP_DIR=${INSTALLROOT}/qmp/lib/cmake/QMP \
      -DLLVM_DIR=${INSTALLROOT}/llvm-17/lib/cmake/llvm \
      -DLLD_DIR=${INSTALLROOT}/llvm-17/lib/cmake/lld \
      -DQDP_ENABLE_BACKEND=ROCM \
      -DQDP_BUILD_EXAMPLES=ON \
      -DQDP_ENABLE_LLVM17=ON \
      -DQDP_PROP_OPT=$PKG_PROP_OPT


make -j 8
make install

popd
