mkdir -p build
mkdir -p install

./build_llvm-22.sh
./build_translator.sh
./build_qmp.sh
./build_qdpxx.sh
./build_chroma.sh

