#module use /dist/modulefiles
module load zstd
module load rocm
module load PrgEnv-gnu

# GPU target for the Cray compiler wrappers: CC/cc then link MPICH's GTL
# library (libmpi_gtl_hsa), needed for GPU-aware MPI (-gpudirect, with
# MPICH_GPU_SUPPORT_ENABLED=1 at run time)
module load craype-accel-amd-gfx90a

export MPICH_GPU_SUPPORT_ENABLED=1

export CXX=CC
export CC=cc

export TOPDIR_HIP=`pwd`
export SRCROOT=${TOPDIR_HIP}/../src
export BUILDROOT=${TOPDIR_HIP}/build
export INSTALLROOT=${TOPDIR_HIP}/install
export LD_LIBRARY_PATH=${INSTALLROOT}/llvm-22/lib:${LD_LIBRARY_PATH}

