source ./env.sh
pushd ${BUILDROOT}

if [ -d ./build_chroma ];
then
  rm -rf ./build_chroma
fi

#

mkdir  ./build_chroma
cd ./build_chroma
cmake ${SRCROOT}/chroma \
      -DCMAKE_BUILD_TYPE=Release \
      -DChroma_ENABLE_CPP_WILSON_DSLASH=ON \
      -DQDPXX_DIR=${INSTALLROOT}/qdpxx/lib/cmake/QDPXX \
      -DQMP_DIR=${INSTALLROOT}/qmp/lib/cmake/QMP \
      -DCMAKE_INSTALL_PREFIX=${INSTALLROOT}/chroma

make -j 8
make install


popd
