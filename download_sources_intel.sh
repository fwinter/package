#!/bin/bash

mkdir -p src/

pushd src
git clone --recursive --branch llvm_release_220 https://github.com/KhronosGroup/SPIRV-LLVM-Translator.git

git clone https://github.com/usqcd-software/qmp.git
git clone --recursive https://github.com/JeffersonLab/qdp-jit.git
git clone --recursive --branch devel https://github.com/JeffersonLab/chroma.git

wget https://github.com/llvm/llvm-project/releases/download/llvmorg-22.1.0/llvm-project-22.1.0.src.tar.xz
echo "Unpacking LLVM."
tar xf llvm-project-22.1.0.src.tar.xz
rm -f llvm-project-22.1.0.src.tar.xz

popd
