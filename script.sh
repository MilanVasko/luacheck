#!/usr/bin/env bash

# print all the executed commands
set -x

# exit if an error occurs
set -e

pkg_dir="$PWD"
pkg_name="`basename $pkg_dir`"
pkg_install_dir="$pkg_dir/../_luadist_install"
luadist_dir="$pkg_dir/../_luadist_bootstrap/_install"

# try to install
$luadist_dir/bin/lua $luadist_dir/lib/lua/luadist.lua $pkg_install_dir install $pkg_name

