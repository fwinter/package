
module use /dist/modulefiles

module load gcc/10.2.0
module load mpi/openmpi-x86_64

#module load mpi/mvapich2-x86_64
#module load rocm/4.3.0
#module load rocm/4.5.2
#module load rocm/5.1.3
module load rocm
#module load cmake/3.21.1
module load cmake/3.23.2


export CXX=CC
export CC=cc

PKG_PROP_OPT=ON

export TOPDIR_HIP=`pwd`
export SRCROOT=${TOPDIR_HIP}/../src
export BUILDROOT=${TOPDIR_HIP}/build
export INSTALLROOT=${TOPDIR_HIP}/install
export LD_LIBRARY_PATH=${ROCM_PATH}/llvm/lib:${LD_LIBRARY_PATH}
