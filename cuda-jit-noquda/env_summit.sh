
module unload xl
module load gcc/11.1.0
module load cmake
module load cuda/11.4.2

export CXX=mpicxx
export CC=mpicc

export TOPDIR_HIP=`pwd`
export SRCROOT=${TOPDIR_HIP}/../src
export BUILDROOT=${TOPDIR_HIP}/build
export INSTALLROOT=${TOPDIR_HIP}/install
export LD_LIBRARY_PATH=${INSTALLROOT}/llvm-13/lib:${LD_LIBRARY_PATH}
