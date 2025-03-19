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



cmake ${SRCROOT}/qdpxx \
      -DCMAKE_BUILD_TYPE=Release \
      -DQDP_PRECISION=single \
      -DCMAKE_INSTALL_PREFIX=${INSTALLROOT}/qdpxx \
      -DQMP_DIR=${INSTALLROOT}/qmp/lib/cmake/QMP




make -j 8
make install


popd
