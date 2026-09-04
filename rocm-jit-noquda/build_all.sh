mkdir -p build
mkdir -p install

#./build_llvm-17.sh
#./build_llvm-22.sh
./build_llvm-18.sh
./build_qmp.sh
./build_qdpxx.sh
./build_chroma.sh

