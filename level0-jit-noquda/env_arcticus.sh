
module use /soft/restricted/CNDA/modulefiles

module load oneapi
module load cmake
module load tools/whichlib

#module switch -f --no-auto intel_compute_runtime intel_compute_runtime/release/agama-prerelease-438


#export CXX=g++
#export CC=gcc

export CXX=mpicxx
export CC=mpicc

PKG_PROP_OPT=ON

export TOPDIR_HIP=`pwd`
export SRCROOT=${TOPDIR_HIP}/../src
export BUILDROOT=${TOPDIR_HIP}/build
export INSTALLROOT=${TOPDIR_HIP}/install
export LD_LIBRARY_PATH=${INSTALLROOT}/llvm-13/lib:${LD_LIBRARY_PATH}

#export LD_LIBRARY_PATH=${ROCM_PATH}/llvm/lib:${LD_LIBRARY_PATH}
