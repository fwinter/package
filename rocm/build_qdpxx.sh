source ./env.sh
pushd ${BUILDROOT}

if [ -d ./build_qdpxx ];
then
  rm -rf ./build_qdpxx
fi

mkdir  ./build_qdpxx
cd ./build_qdpxx


cmake ${SRCROOT}/qdp-jit \
      -DCMAKE_BUILD_TYPE=Release \
      -DQDP_ENABLE_HOST_COMPILER=ON \
      -DQDP_JIT_ROCM_COMGR_LINK=ON \
      -DQDP_BUILD_EXAMPLES=ON \
      -DQDP_ENABLE_LLVM22=ON \
      -DQDP_ENABLE_BACKEND=ROCM \
      -DQDP_PRECISION=double \
      -DCMAKE_INSTALL_PREFIX=${INSTALLROOT}/qdpxx \
      -DQMP_DIR=${INSTALLROOT}/qmp/lib/cmake/QMP \
      -DLLVM_DIR=${INSTALLROOT}/llvm-22/lib/cmake/llvm


make -j 8
make install

popd
