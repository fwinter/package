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
      -DQDP_ENABLE_MANAGED_MEMORY=OFF \
      -DCMAKE_BUILD_TYPE=Release \
      -DQDP_PRECISION=double \
      -DCMAKE_INSTALL_PREFIX=${INSTALLROOT}/qdpxx \
      -DQMP_DIR=${INSTALLROOT}/qmp/lib/cmake/QMP \
      -DLLVM_DIR=${INSTALLROOT}/llvm-15/lib/cmake/llvm \
      -DQDP_ENABLE_BACKEND=CUDA \
      -DQDP_BUILD_EXAMPLES=ON \
      -DQDP_ENABLE_LLVM15=ON \
      -DQDP_PROP_OPT=$PKG_PROP_OPT


make -j 8
make install

popd
