mkdir -p build
mkdir -p install

./build_llvm-13.sh
./build_level-zero.sh
./build_translator.sh

./build_qmp.sh
./build_qdpxx.sh
#./build_chroma.sh

