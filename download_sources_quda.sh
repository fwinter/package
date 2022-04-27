#!/bin/bash

mkdir -p src/

pushd src
git clone --recursive --branch develop https://github.com/lattice/quda.git
popd
