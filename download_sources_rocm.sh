#!/bin/bash

mkdir -p src/

pushd src
git clone https://github.com/usqcd-software/qmp.git
git clone --recursive --branch devel https://github.com/JeffersonLab/qdp-jit.git
git clone --recursive --branch devel https://github.com/JeffersonLab/chroma.git

wget https://github.com/llvm/llvm-project/releases/download/llvmorg-17.0.6/llvm-project-17.0.6.src.tar.xz
echo "Unpacking LLVM. This takes a moment."
tar xf llvm-project-17.0.6.src.tar.xz
rm -f llvm-project-17.0.6.src.tar.xz

popd

