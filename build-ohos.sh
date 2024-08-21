#! /bin/bash

mkdir -p ffi/build
mkdir -p lib
cd ffi/build

# -DCMAKE_CXX_COMPILER 和 -DCMAKE_CXX_FLAGS 路径自行设置
cmake .. -DCMAKE_VERBOSE_MAKEFILE=ON -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER="D:/ohos/OHCangjie0.4.5-OH5.0.0.22/native/llvm/bin/clang++.exe" -DCMAKE_CXX_FLAGS="--sysroot=D:/ohos/OHCangjie0.4.5-OH5.0.0.22/native/sysroot --target=aarch64-linux-ohos" -DCMAKE_SYSTEM_NAME=linux -DCMAKE_SYSTEM_PROCESSOR=aarch64  -G "MinGW Makefiles" -DCMAKE_STRIP="D:/ohos/OHCangjie0.4.5-OH5.0.0.22/native/llvm/bin/llvm-strip.exe"
make -j20

cp liblatex.so ../../lib/
cd ../../
cjpm build --target aarch64-linux-ohos
