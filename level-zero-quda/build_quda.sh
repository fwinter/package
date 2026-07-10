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

#      -DCUDAToolkit_ROOT_DIR=$CUDA_TOOLKIT_ROOT_DIR \

LARGE_REGS=1

export QUDA_TARGET=SYCL
export CC=mpicc
export CXX=mpicxx

export QUDA_SYCL_TARGETS="spir64_gen"
export SYCL_LINK_FLAGS="$SYCL_LINK_FLAGS -Xs \"-device pvc\""

#export QUDA_SYCL_TARGETS="spir64_x86_64"
#export SYCL_LINK_FLAGS="$SYCL_LINK_FLAGS -Xs -march=avx512"
#LARGE_REGS=0

#export QUDA_SYCL_TARGETS="native_cpu"
#CXXFLAGS="-D __SYCL_NATIVE_CPU__"

export SYCL_LINK_FLAGS="$SYCL_LINK_FLAGS -fsycl-device-code-split=per_kernel"
export SYCL_LINK_FLAGS="$SYCL_LINK_FLAGS -fsycl-max-parallel-link-jobs=32"
export SYCL_LINK_FLAGS="$SYCL_LINK_FLAGS -flink-huge-device-code"

export QUDA_WARP_SIZE=16
#export QUDA_WARP_SIZE=32
export QUDA_MAX_BLOCK_SIZE=1024
export QUDA_MAX_ARGUMENT_SIZE=2048
export QUDA_TEST_NUMPROCS=1

prefix="${INSTALLROOT}/quda"

if [ "X$LARGE_REGS" = "X1" ]; then
  echo "Using large register file"
  #export CXXFLAGS="$CXXFLAGS -Xs \"-options -ze-opt-large-register-file\""
  #export LDFLAGS="$LDFLAGS -Xs \"-options -ze-opt-large-register-file\""
  #export SYCL_FLAGS="$SYCL_FLAGS -Xs \"-options -ze-opt-large-register-file\""
  export SYCL_LINK_FLAGS="$SYCL_LINK_FLAGS -Xs \"-options -ze-opt-large-register-file\""
  export QUDA_MAX_BLOCK_SIZE=512
  #prefix="$PRJ/lqcd/install/quda-git-sycl-256"
fi
#export SYCL_FLAGS="-gline-tables-only"
#export SYCL_FLAGS="$CXXFLAGS"
#CXXFLAGS=""
#export CXXFLAGS="-fsycl $SYCL_FLAGS"
#SYCL_FLAGS=""
#export LDFLAGS="-fsycl $SYCL_LINK_FLAGS"
#SYCL_LINK_FLAGS=""

o="$o -DCMAKE_INSTALL_PREFIX=$prefix"

#o="$o -DCMAKE_BUILD_TYPE=DEVEL"
o="$o -DCMAKE_BUILD_TYPE=RELEASE"
#o="$o -DCMAKE_BUILD_TYPE=STRICT"
#o="$o -DCMAKE_BUILD_TYPE=DEBUG"

#o="$o -DQUDA_BLOCKSOLVER=ON"
o="$o -DQUDA_CONTRACT=ON"
o="$o -DQUDA_COVDEV=ON"
o="$o -DQUDA_LAPLACE=ON"
o="$o -DQUDA_MULTIGRID=ON"
o="$o -DQUDA_SMEAR_GAUSS_TWOLINK=ON"

#o="$o -DQUDA_DIRAC_DEFAULT_OFF=ON"
#o="$o -DQUDA_DIRAC_STAGGERED=ON"
#o="$o -DQUDA_DIRAC_WILSON=ON"
#o="$o -DQUDA_DIRAC_CLOVER=ON"
#o="$o -DQUDA_DIRAC_CLOVER_HASENBUSCH=ON"
#o="$o -DQUDA_DIRAC_TWISTED_MASS=OFF"
#o="$o -DQUDA_DIRAC_TWISTED_CLOVER=OFF"
#o="$o -DQUDA_DIRAC_NDEG_TWISTED_MASS=OFF"
#o="$o -DQUDA_DIRAC_NDEG_TWISTED_CLOVER=OFF"
#o="$o -DQUDA_DIRAC_DOMAIN_WALL=ON"

o="$o -DQUDA_CTEST_DISABLE_BENCHMARKS=OFF"
o="$o -DQUDA_BUILD_ALL_TESTS=OFF"
o="$o -DQUDA_INSTALL_ALL_TESTS=OFF"

#o="$o -DQUDA_BUILD_NATIVE_LAPACK=OFF"
#o="$o -DQUDA_BUILD_NATIVE_FFT=OFF"
#o="$o -DQUDA_PRECISION=12"
#o="$o -DQUDA_RECONSTRUCT=4"

o="$o -DQUDA_FAST_COMPILE_REDUCE=ON"
o="$o -DQUDA_FAST_COMPILE_DSLASH=ON"
o="$o -DQUDA_BUILD_SHAREDLIB=OFF"
o="$o -DBUILD_SHARED_LIBS=OFF"

o="$o -DQUDA_MPI=OFF"
o="$o -DMPIEXEC_EXECUTABLE=`which mpiexec`"


o="$o -DQUDA_QDPJIT=ON"
o="$o -DQDPXX_DIR=${INSTALLROOT}/qdpxx/lib/cmake/QDPXX"
o="$o -DLLVM_DIR=${INSTALLROOT}/llvm-16/lib/cmake/llvm"
o="$o -DQUDA_INTERFACE_QDPJIT=OFF"
o="$o -DQUDA_QMP=ON"
o="$o -DQMP_DIR=${INSTALLROOT}/qmp/lib/cmake/QMP"
o="$o -DQUDA_QIO=OFF"
o="$o -DQUDA_DOWNLOAD_EIGEN=ON"


L0=$(whichlib libze_loader.so |& sed "s+lib64.*++" | head -n 1)
echo ${L0}

o="$o -DLevelZero_INCLUDE_DIR=${L0}/include"
o="$o -DLevelZero_LIBRARY=${L0}/lib64"


echo "QUDA_TARGET:"
echo $QUDA_TARGET
echo "QUDA_SYCL_TARGETS:"
echo $QUDA_SYCL_TARGETS
echo "SYCL_FLAGS:"
echo $SYCL_FLAGS
echo "SYCL_LINK_FLAGS:"
echo $SYCL_LINK_FLAGS
echo "CXXFLAGS:"
echo $CXXFLAGS
echo "LDFLAGS:"
echo $LDFLAGS

echo cmake $o ${SRCROOT}/quda
cmake $o ${SRCROOT}/quda



make -j 16
make install

popd
