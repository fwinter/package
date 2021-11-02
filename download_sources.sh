#!/bin/bash

mkdir -p src/

pushd src
git clone https://github.com/usqcd-software/qmp.git
git clone --recursive --branch devel https://github.com/JeffersonLab/qdp-jit.git
git clone --recursive --branch devel https://github.com/JeffersonLab/chroma.git
wget https://github.com/llvm/llvm-project/releases/download/llvmorg-13.0.0/llvm-13.0.0.src.tar.xz
tar xf llvm-13.0.0.src.tar.xz
rm -f llvm-13.0.0.src.tar.xz
popd
