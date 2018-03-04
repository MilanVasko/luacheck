#!/usr/bin/env bash

# print all the executed commands
set -x

# exit if an error occurs
set -e

# try to install
$LUADIST_DIR/bin/lua $LUADIST_DIR/lib/lua/luadist.lua $PKG_INSTALL_DIR install $PKG_NAME

