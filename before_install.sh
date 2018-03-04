#!/usr/bin/env bash


# print all the executed commands
set -x

# exit if an error occurs
set -e


pkg_dir="$PWD"
export PKG_NAME="`basename $pkg_dir`"
export PKG_INSTALL_DIR="$pkg_dir/../_luadist_install"

luadist_bootstrap_dir="$pkg_dir/../_luadist_bootstrap"
export LUADIST_DIR="$luadist_bootstrap_dir/_install"

# get the bootstrap script
git clone --depth 1 https://github.com/LuaDist-core/bootstrap $luadist_bootstrap_dir

# run it
cd $luadist_bootstrap_dir
./bootstrap

# TODO: remove eventually!
# workaround for broken sockets
rm "$luadist_bootstrap_dir/_install/lib/lua/socket" -rf
cp "$luadist_bootstrap_dir/_bootstrap/lib/lua/socket" "$luadist_bootstrap_dir/_install/lib/lua/socket" -r

# TODO: remove eventually!
# workaround for downloading the latest LuaDist2 instead of the versioned one
luadist2_workaround_dir="$PWD/_luadist2_workaround"
git clone --depth 1 https://github.com/LuaDist-core/luadist2 $luadist2_workaround_dir
cd $luadist2_workaround_dir
# simulate CMake
sed -e 's/@luadist2_VERSION@/0\.8\.2/' -e 's/@PLATFORM@/{"unix"}/' ./dist/config.in.lua > ./dist/config.lua
cd -
rm "$LUADIST_DIR/lib/lua/dist" "$LUADIST_DIR/lib/lua/luadist.lua" -rf
cp "$luadist2_workaround_dir/dist" "$LUADIST_DIR/lib/lua/" -r
cp "$luadist2_workaround_dir/luadist.lua" "$LUADIST_DIR/lib/lua/luadist.lua"
rm $luadist2_workaround_dir -rf

