INSTALL_NAME="@rpath/Lua.framework/Versions/A/Lua"

export MACOSX_DEPLOYMENT_TARGET=10.7

# build x64
make clean
make -j8 TARGET_FLAGS="-arch x86_64"
install_name_tool -id $INSTALL_NAME src/libluajit.a
cp src/libluajit.a libluajit_x86_64.a

# build arm64
make clean
make -j8 TARGET_FLAGS="-arch arm64"
install_name_tool -id $INSTALL_NAME src/libluajit.a
cp src/libluajit.a libluajit_arm64.a

# combine lib
lipo -create -output libluajit.a libluajit_arm64.a libluajit_x86_64.a

make clean
cp libluajit.a ../../macos/libluajit.a
rm libluajit_arm64.a
rm libluajit_x86_64.a
rm libluajit.a