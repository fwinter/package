source ./env.sh
pushd ${INSTALLROOT}/
rm -rf libxml2 qmp qdpxx quda chroma
popd
pushd ${BUILDROOT}
rm -rf ./build_libxml2  ./build_qdpxx  ./build_qmp  ./build_quda ./build_chroma
popd
