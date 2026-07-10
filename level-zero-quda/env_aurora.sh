
#module use /soft/restricted/CNDA/modulefiles
module use /soft/modulefiles
#module load spack-pe-gcc/0.4-rc1

module load oneapi
module load whichlib
#module load spack 
#module load spack-pe-gcc
module load cmake
#module load libxml2
#module load tools/whichlib
#module load oneapi/eng-compiler/2023.10.15.002
#module load mpich/dbg/5.0.0.aurora_test.06f012a

export CXX=mpicxx
export CC=mpicc

export http_proxy="http://proxy.alcf.anl.gov:3128"
export https_proxy="http://proxy.alcf.anl.gov:3128"

PKG_PROP_OPT=ON

export TOPDIR_HIP=`pwd`
export SRCROOT=${TOPDIR_HIP}/../src
export BUILDROOT=${TOPDIR_HIP}/build
export INSTALLROOT=${TOPDIR_HIP}/install
export LD_LIBRARY_PATH=${INSTALLROOT}/llvm-16/lib:${LD_LIBRARY_PATH}

