source ./env.sh
pushd ${BUILDROOT}

if [ -d ./build_qmp ];
then
  rm -rf ./build_qmp
fi

mkdir  ./build_qmp
cd ./build_qmp

	
cmake ${SRCROOT}/qmp \
      -DCMAKE_BUILD_TYPE=Release \
      -DQMP_MPI=ON \
      -DCMAKE_INSTALL_PREFIX=${INSTALLROOT}/qmp


make -j 8
make install

popd

