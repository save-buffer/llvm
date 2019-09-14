#!/bin/sh
cd /llvm-project
git fetch
git reset --hard origin/master
git apply /workspace/p.patch
if [ -d /build]; then rm -rf /build; fi
mkdir /build
cd /build
cmake -G Ninja /llvm-project/llvm \
      -DLLVM_USE_LINKER=gold \
      -DLLVM_TARGETS_TO_BUILD="X86" \
      -DLLVM_PARALLEL_LINK_JOBS=8 \
      -DLLVM_BUILD_TOOLS=OFF
ninja
cd /

OBJ_FILES=' '
if ls build/lib/*.so >/dev/null 2>&1; then OBJ_FILES="$OBJ_FILES build/lib/*.so"; fi
if ls build/lib/*.a >/dev/null 2>&1; then OBJ_FILES="$OBJ_FILES build/lib/*.a"; fi
if ls build/lib/*.lib >/dev/null 2>&1; then OBJ_FILES="$OBJ_FILES build/lib/*.lib"; fi
echo "Tarring up $OBJ_FILES"
tar cvf build.tar $OBJ_FILES
