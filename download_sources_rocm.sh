#!/bin/bash

mkdir -p src/

pushd src
git clone https://github.com/usqcd-software/qmp.git
git clone --recursive --branch devel https://github.com/JeffersonLab/qdp-jit.git
git clone --recursive --branch devel https://github.com/JeffersonLab/chroma.git
popd

