source ./env.sh
pushd ${BUILDROOT}

if [ -d ./build_level-zero ];
then
  rm -rf ./build_level-zero
fi

mkdir  ./build_level-zero
cd ./build_level-zero



cmake ${SRCROOT}/level-zero \
      -DCMAKE_BUILD_TYPE=Debug \
      -DCMAKE_INSTALL_PREFIX=${INSTALLROOT}/level-zero


make -j 4
make install

popd

