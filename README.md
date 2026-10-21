# Chroma build package for GPUs

Scripts that download and build [Chroma](https://github.com/JeffersonLab/chroma)
on top of [qdp-jit](https://github.com/JeffersonLab/qdp-jit) for NVIDIA, AMD
and Intel GPUs. One command builds LLVM, QMP, qdp-jit and Chroma in the right
order, with matching options, and installs them next to each other.

qdp-jit is the GPU implementation of QDP++: it compiles every lattice
expression into a GPU kernel at run time with LLVM. Its documentation is at
<https://jeffersonlab.github.io/qdp-jit/>.

## Contents

| GPU | Download script | Build directory | What it builds |
|---|---|---|---|
| NVIDIA | `download_sources_cuda.sh` | `cuda/` | LLVM, QMP, qdp-jit (CUDA), Chroma |
| AMD | `download_sources_rocm.sh` | `rocm/` | LLVM, QMP, qdp-jit (ROCm), Chroma |
| Intel | `download_sources_intel.sh` | `level-zero/` | LLVM, SPIR-V translator, QMP, qdp-jit (Level Zero), Chroma |
| CPU only | `download_sources_x86.sh` | `x86/` | QMP, QDP++, Chroma |

The download scripts put all sources into `src/`. Each build directory has
its own `env.sh` and build scripts, and builds and installs into its own
`build/` and `install/` subdirectories, so several architectures can be built
from one clone.

## Prerequisites

Load these first, on a cluster usually with `module load`:

- the GPU software: the CUDA toolkit, ROCm, or oneAPI with Level Zero
- MPI with its compiler wrappers (`mpicxx`, `mpicc`, or `CC`, `cc` on Cray)
- a C++ compiler, CMake, `git` and `wget`

The package builds LLVM from source, so no LLVM installation is needed.

## Quick start

The steps below build for NVIDIA GPUs. For AMD or Intel GPUs, use the
download script and directory from the table above.

### 1. Get the package and the sources

```bash
git clone https://github.com/fwinter/package.git
cd package
./download_sources_cuda.sh
```

This clones QMP, qdp-jit and Chroma and downloads the LLVM 22 sources into
`src/`.

### 2. Configure `env.sh`

```bash
cd cuda
```

Every build script starts by sourcing `env.sh`. Edit it for your system:

```bash
export CXX=mpicxx      # your MPI C++ compiler wrapper
export CC=mpicc        # your MPI C compiler wrapper
```

and add the `module load` lines your system needs. For some machines there
are ready-made files to start from:

| Directory | Machine files |
|---|---|
| `cuda/` | `env_perlmutter.sh`, `env_polaris.sh`, `env_summit.sh`, `env_generic.sh` |
| `rocm/` | `env_frontier.sh`, `env_birch.sh`, `env_21g.sh` |
| `level-zero/` | `env_aurora.sh`, `env_sunspot.sh`, `env_arcticus.sh` |
| `x86/` | `env_generic.sh` |

For example, `cp env_perlmutter.sh env.sh`. The rest of `env.sh` sets the
locations of the sources, the build and the installation, and adds the LLVM
libraries to `LD_LIBRARY_PATH`; keep these lines.

### 3. Check the host CPU architecture

LLVM is built for the GPU and for the host CPU, because qdp-jit also compiles
scalar expressions for the CPU. The scripts are set up for x86 hosts. If the
compute nodes have ARM CPUs (for example NVIDIA Grace), change `X86` to
`AArch64` in `LLVM_TARGETS_TO_BUILD` in `build_llvm-22.sh`:

| GPU | x86 host | ARM host |
|---|---|---|
| NVIDIA | `"NVPTX;X86"` | `"NVPTX;AArch64"` |
| AMD | `"AMDGPU;X86"` | `"AMDGPU;AArch64"` |
| Intel | `"X86"` | `"AArch64"` |

### 4. Build

```bash
./build_all.sh
```

This builds and installs each component in turn; LLVM takes the longest.
When it has finished:

```
cuda/
├── build/              build directories, one per component
└── install/
    ├── llvm-22/
    ├── qmp/
    ├── qdpxx/          qdp-jit
    └── chroma/
        └── bin/chroma
```

## Running Chroma

LLVM is installed as shared libraries, so `chroma` needs
`install/llvm-22/lib` on `LD_LIBRARY_PATH` at run time. `env.sh` sets it, so a
job script can source the same `env.sh` to get the modules, the variables and
the library path. `env.sh` takes its paths from the current directory, so
change to the build directory before sourcing it:

```bash
#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --gpus-per-node=4

cd /path/to/package/cuda
source ./env.sh

cd /path/to/run
srun ${INSTALLROOT}/chroma/bin/chroma -i input.xml -o output.xml -geom 1 1 1 4
```

Start one MPI rank per GPU, and give the grid of ranks with `-geom`. Useful
qdp-jit options:

| Option | Description |
|---|---|
| `-geom Px Py Pz Pt` | the grid of MPI ranks |
| `-poolsize SIZE` | the GPU memory pool, e.g. `20g`; default 92% of the free GPU memory |
| `-gpudirect` | use a GPU-aware MPI: communicate directly from GPU memory |
| `-pool-reserve SIZE` | GPU memory kept outside the pool, e.g. for the communication buffers of `-gpudirect` (with `-gpudirect`, 10% of the free memory by default) |
| `-timing-run` | correct timings with `StopWatch` |

All options are described in the
[qdp-jit documentation](https://jeffersonlab.github.io/qdp-jit/options/).

## Rebuilding a component

Each component has its own script (`build_llvm-22.sh`, `build_qmp.sh`,
`build_qdpxx.sh`, `build_chroma.sh`), run from the build directory. Each
script removes its build directory first, so every run is a clean build.
After a change to qdp-jit, rebuild qdp-jit and then Chroma:

```bash
./build_qdpxx.sh
./build_chroma.sh
```

## Changing build options

The CMake options are set in the build scripts. To change one, edit the
`cmake` command in the script and rebuild that component. The main options of
qdp-jit, in `build_qdpxx.sh`:

| Option | Values |
|---|---|
| `QDP_PRECISION` | `double` (set by the scripts), `single` |
| `QDP_ND`, `QDP_NC`, `QDP_NS` | 4, 3, 4 (default) |
| `QDP_LAYOUT` | `cb2` (default), `lexico`, `cb3d` |
| `QDP_ENABLE_HOST_COMPILER` | `ON` (default), `OFF` |

See [Download and build](https://jeffersonlab.github.io/qdp-jit/building/)
in the qdp-jit documentation for more.

Each script sets its own `make -j` level. On a login node with little memory,
lower it, in particular in `build_chroma.sh`.

## CPU-only build

`x86/` builds Chroma on [QDP++](https://github.com/JeffersonLab/qdpxx), the
CPU implementation, without LLVM or a GPU:

```bash
./download_sources_x86.sh
cd x86
# edit env.sh
./build_all.sh
```
