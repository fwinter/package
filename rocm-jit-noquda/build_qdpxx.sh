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

#       -DLLVM_DIR=${INSTALLROOT}/llvm-13/lib/cmake/llvm \

cmake ${SRCROOT}/qdp-jit \
       -DQDP_PRECISION=double \
       -DCMAKE_INSTALL_PREFIX=${INSTALLROOT}/qdpxx \
       -DQMP_DIR=${INSTALLROOT}/qmp/lib/cmake/QMP \
       -DQDP_ENABLE_BACKEND=ROCM \
       -DQDP_BUILD_EXAMPLES=OFF \
       -DQDP_ROCM5FIX=ON \
       -DQDP_ENABLE_LLVM14=ON \
       -DQDP_PROP_OPT=$PKG_PROP_OPT


make -j 32
make install

popd
