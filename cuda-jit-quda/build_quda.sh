source ./env.sh
pushd ${BUILDROOT}

if [ -d ./build_quda ];
then
  rm -rf ./build_quda
fi

mkdir  ./build_quda
cd ./build_quda


if [ ! -z "${CUDADIR}" ]
then
    export CUDA_TOOLKIT_ROOT_DIR=${CUDADIR}
fi

#      -DQUDA_DYNAMIC_CLOVER=OFF \
#      -DQUDA_MAGMA=OFF        \


cmake ${SRCROOT}/quda \
      -G "Unix Makefiles" \
      -DQUDA_TARGET_TYPE="CUDA" \
      -DQUDA_DIRAC_CLOVER=ON \
      -DQUDA_DIRAC_CLOVER_HASENBUSCH=ON \
      -DQUDA_DIRAC_DOMAIN_WALL=OFF \
      -DQUDA_DIRAC_NDEG_TWISTED_MASS=OFF \
      -DQUDA_DIRAC_STAGGERED=ON \
      -DQUDA_DIRAC_TWISTED_MASS=OFF \
      -DQUDA_DIRAC_TWISTED_CLOVER=OFF \
      -DQUDA_DIRAC_WILSON=ON \
      -DQUDA_FORCE_GAUGE=ON \
      -DQUDA_FORCE_HISQ=OFF \
      -DQUDA_GAUGE_ALG=OFF \
      -DQUDA_GAUGE_TOOLS=OFF \
      -DQUDA_QDPJIT=ON \
      -DQDPXX_DIR=${INSTALLROOT}/qdpxx/lib/cmake/QDPXX \
      -DLLVM_DIR=${INSTALLROOT}/llvm-13/lib/cmake/llvm \
      -DCUDAToolkit_ROOT_DIR=$CUDA_TOOLKIT_ROOT_DIR \
      -DQUDA_INTERFACE_QDPJIT=ON \
      -DQUDA_INTERFACE_MILC=OFF \
      -DQUDA_INTERFACE_CPS=OFF \
      -DQUDA_INTERFACE_QDP=OFF \
      -DQUDA_INTERFACE_TIFR=OFF \
      -DQUDA_QMP=ON \
      -DQMP_DIR=${INSTALLROOT}/qmp/lib/cmake/QMP \
      -DQUDA_QIO=OFF \
      -DQUDA_OPENMP=OFF \
      -DQUDA_MULTIGRID=ON \
      -DQUDA_MAX_MULTI_BLAS_N=9 \
      -DQUDA_DOWNLOAD_EIGEN=ON \
      -DCMAKE_INSTALL_PREFIX=${INSTALLROOT}/quda \
      -DCMAKE_BUILD_TYPE="DEVEL" \
      -DCMAKE_CXX_COMPILER=${CXX}\
      -DCMAKE_CXX_STANDARD=17 \
      -DCMAKE_CXX_EXTENSIONS=OFF \
      -DCMAKE_C_COMPILER=${CC} \
      -DBUILD_SHARED_LIBS=OFF \
      -DQUDA_BUILD_SHAREDLIB=OFF \
      -DQUDA_BUILD_ALL_TESTS=OFF \
      -DQUDA_CTEST_DISABLE_BENCHMARKS=ON \
      -DQUDA_HETEROGENEOUS_ATOMIC=OFF


make -j 32
make install

popd
