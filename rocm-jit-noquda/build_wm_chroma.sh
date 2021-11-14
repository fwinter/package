source ./env.sh
pushd ${BUILDROOT}

if [ -d ./build_wm_chroma ];
then
  rm -rf ./build_wm_chroma
fi

#      -DLLVM_DIR=${INSTALLROOT}/llvm-13/lib/cmake/llvm \


mkdir  ./build_wm_chroma
cd ./build_wm_chroma
cmake ${SRCROOT}/wm_chroma \
      -DQDPXX_DIR=${INSTALLROOT}/qdpxx/lib/cmake/QDPXX \
      -DQMP_DIR=${INSTALLROOT}/qmp/lib/cmake/QMP \
      -DChroma_DIR=${INSTALLROOT}/chroma/lib/cmake/Chroma \
      -DCMAKE_INSTALL_PREFIX=${INSTALLROOT}/wm_chroma

make -j 16
make install


popd
