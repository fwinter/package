source ./env.sh
pushd ${BUILDROOT}

if [ -d ./build_translator ];
then
  rm -rf ./build_translator
fi

mkdir  ./build_translator
cd ./build_translator



cmake ${SRCROOT}/SPIRV-LLVM-Translator \
      -DCMAKE_BUILD_TYPE=Debug \
      -DLLVM_DIR=${INSTALLROOT}/llvm-13/lib/cmake/llvm \
      -DLLVM_EXTERNAL_SPIRV_HEADERS_SOURCE_DIR=${SRCROOT}/SPIRV-Headers \
      -DCMAKE_INSTALL_PREFIX=${INSTALLROOT}/translator \
      -DLLVM_SPIRV_BUILD_EXTERNAL=YES

make -j 4
make install

popd

