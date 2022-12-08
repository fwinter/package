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
       -DQDP_PRECISION=double \
       -DCMAKE_INSTALL_PREFIX=${INSTALLROOT}/qdpxx \
       -DQMP_DIR=${INSTALLROOT}/qmp/lib/cmake/QMP \
       -DLLD_DIR=${ROCM_PATH}/llvm/lib/cmake/lld \
       -DQDP_ENABLE_BACKEND=ROCM \
       -DQDP_BUILD_EXAMPLES=OFF \
       -DQDP_ENABLE_LLVM15=ON \
       -DQDP_PROP_OPT=$PKG_PROP_OPT


make -j 8
make install

popd
