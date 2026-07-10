source ./env.sh
pushd ${BUILDROOT}

if [ -d ./build_mg ];
then
  rm -rf ./build_mg
fi

#      -DLLVM_DIR=${INSTALLROOT}/llvm-13/lib/cmake/llvm \
#      -DChroma_ENABLE_LAPACK=ON \

mkdir  ./build_mg
cd ./build_mg
cmake ${SRCROOT}/mg \
      -DLevelZero_INCLUDE_DIR=${L0}/include \
      -DLevelZero_LIBRARY=${L0}/lib64 \
      -DCMAKE_BUILD_TYPE=Release \
      -DQDPXX_DIR=${INSTALLROOT}/qdpxx/lib/cmake/QDPXX \
      -DQMP_DIR=${INSTALLROOT}/qmp/lib/cmake/QMP \
      -DLLVM_DIR=${INSTALLROOT}/llvm-16/lib/cmake/llvm \
      -DCMAKE_INSTALL_PREFIX=${INSTALLROOT}/mg

make -j 1
#make install


popd
