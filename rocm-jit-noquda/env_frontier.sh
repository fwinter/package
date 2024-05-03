
#module use /dist/modulefiles

#module load gcc/10.2.0
#module load mpi/openmpi-x86_64

#module load mpi/mvapich2-x86_64
#module load rocm/4.3.0
#module load rocm/5.1.3
#module load rocm/5.2.0
#module load rocm/5.3.0
module load zstd
#module load googletest
#module load rocm/5.4.3
#module load rocm/5.5.1
#module load rocm/5.6.0
#module load rocm/5.7.1
module load rocm/6.0.0 
module load PrgEnv-gnu
#module load cmake/3.21.1



export CXX=CC
export CC=cc

PKG_PROP_OPT=ON

export TOPDIR_HIP=`pwd`
export SRCROOT=${TOPDIR_HIP}/../src
export BUILDROOT=${TOPDIR_HIP}/build
export INSTALLROOT=${TOPDIR_HIP}/install
#export LD_LIBRARY_PATH=${ROCM_PATH}/llvm/lib:${LD_LIBRARY_PATH}
export LD_LIBRARY_PATH=${INSTALLROOT}/llvm-17/lib:${LD_LIBRARY_PATH}

