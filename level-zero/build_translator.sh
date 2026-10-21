source ./env.sh
pushd ${BUILDROOT}

if [ -d ./build_translator ];
then
  rm -rf ./build_translator
fi

mkdir  ./build_translator
cd ./build_translator



cmake ${SRCROOT}/SPIRV-LLVM-Translator \
      -DCMAKE_BUILD_TYPE=Release \
      -DLLVM_DIR=${INSTALLROOT}/llvm-22/lib/cmake/llvm \
      -DLLVM_EXTERNAL_SPIRV_HEADERS_SOURCE_DIR=${SRCROOT}/SPIRV-Headers \
      -DCMAKE_INSTALL_PREFIX=${INSTALLROOT}/translator \
      -DLLVM_SPIRV_BUILD_EXTERNAL=YES \
      -DCMAKE_DISABLE_FIND_PACKAGE_SPIRV-Tools=ON \
      -DCMAKE_DISABLE_FIND_PACKAGE_SPIRV-Tools-tools=ON

make -j 4
make install

popd

