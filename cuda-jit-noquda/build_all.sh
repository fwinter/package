mkdir -p build
mkdir -p install

./build_llvm-16.sh
./build_qmp.sh
./build_qdpxx.sh
./build_chroma.sh
