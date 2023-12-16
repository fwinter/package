#module use /soft/restricted/CNDA/modulefiles
module use /soft/modulefiles
module load spack-pe-gcc/0.4-rc1

#module load oneapi
#module load spack 
module load cmake
module load libxml2
module load tools/whichlib

export CXX=mpicxx
export CC=mpicc

PKG_PROP_OPT=ON

export TOPDIR_HIP=`pwd`
export SRCROOT=${TOPDIR_HIP}/../src
export BUILDROOT=${TOPDIR_HIP}/build
export INSTALLROOT=${TOPDIR_HIP}/install
export LD_LIBRARY_PATH=${INSTALLROOT}/llvm-16/lib:${LD_LIBRARY_PATH}
