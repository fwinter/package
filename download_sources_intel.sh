#!/bin/bash

mkdir -p src/

pushd src
git clone https://github.com/oneapi-src/level-zero.git
git clone --recursive --branch llvm_release_130 https://github.com/KhronosGroup/SPIRV-LLVM-Translator.git

git clone https://github.com/usqcd-software/qmp.git
git clone --recursive --branch feature/avx https://github.com/fwinter/qdp-jit.git
git clone --recursive --branch feature/avx https://github.com/JeffersonLab/chroma.git
wget https://github.com/llvm/llvm-project/releases/download/llvmorg-13.0.1/llvm-13.0.1.src.tar.xz
echo "Unpacking LLVM. This takes a moment."
tar xf llvm-13.0.1.src.tar.xz
rm -f llvm-13.0.1.src.tar.xz
popd
