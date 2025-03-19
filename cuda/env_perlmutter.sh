

module load PrgEnv-gnu
module load gcc/9.3.0
module load cmake
module load cuda/11.3.0

export CRAY_ACCEL_TARGET=nvidia80
export CXX=CC
export CC=cc

PKG_PROP_OPT=OFF

export TOPDIR_HIP=`pwd`
export SRCROOT=${TOPDIR_HIP}/../src
export BUILDROOT=${TOPDIR_HIP}/build
export INSTALLROOT=${TOPDIR_HIP}/install
export LD_LIBRARY_PATH=${INSTALLROOT}/llvm-14/lib:${LD_LIBRARY_PATH}
