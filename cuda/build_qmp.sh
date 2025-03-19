source ./env.sh
pushd ${BUILDROOT}

if [ -d ./build_qmp ];
then
  rm -rf ./build_qmp
fi

mkdir  ./build_qmp
cd ./build_qmp

#	-DCMAKE_BUILD_TYPE=RelWithDebInfo \
#	-DCMAKE_C_COMPILER=cc \
#  	-DBUILD_SHARED_LIBS=ON \
#	-DCMAKE_C_STANDARD=99 \
#	-DCMAKE_C_EXTENSIONS=OFF
#	-DCMAKE_C_FLAGS="${MPI_CFLAGS}" \
#	-DCMAKE_SHARED_LINKER_FLAGS="${MPI_LDFLAGS}" \
#	-DCMAKE_EXE_LINKER_FLAGS="${MPI_LDFLAGS}"
	
cmake ${SRCROOT}/qmp \
      -DQMP_MPI=ON \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX=${INSTALLROOT}/qmp


make -j 8
make install

popd

