#!/bin/bash

mkdir -p src/

pushd src
##git clone https://github.com/oneapi-src/level-zero.git # use system installation
#git clone --recursive --branch llvm_release_130 https://github.com/KhronosGroup/SPIRV-LLVM-Translator.git
git clone --recursive --branch llvm_release_160 https://github.com/KhronosGroup/SPIRV-LLVM-Translator.git

git clone https://github.com/usqcd-software/qmp.git
git clone --recursive --branch devel https://github.com/JeffersonLab/qdp-jit.git
git clone --recursive --branch devel https://github.com/JeffersonLab/chroma.git

#wget https://github.com/llvm/llvm-project/releases/download/llvmorg-13.0.1/llvm-13.0.1.src.tar.xz
#wget https://github.com/llvm/llvm-project/releases/download/llvmorg-16.0.6/llvm-project-16.0.6.src.tar.xz
wget https://github.com/llvm/llvm-project/releases/download/llvmorg-16.0.4/llvm-project-16.0.4.src.tar.xz
#wget https://github.com/llvm/llvm-project/releases/download/llvmorg-17.0.6/llvm-project-17.0.6.src.tar.xz

echo "Unpacking LLVM. This takes a moment."
tar xf llvm-project-16.0.4.src.tar.xz
rm -f llvm-project-16.0.4.src.tar.xz

popd
