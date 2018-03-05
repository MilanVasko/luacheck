#!/usr/bin/env bash

set -xe

pkg_dir="$PWD"
pkg_name="`basename $pkg_dir`"
report_file="$pkg_dir/../_luadist_install/*.md"
cloned_repo="$pkg_dir/../_luadist_packages_web"

git config --global user.email "travis@travis-ci.org"
git config --global user.name "Travis CI"
git clone https://github.com/MilanVasko/LuaDist2-Packages $cloned_repo
cp $report_file $cloned_repo
cd $cloned_repo
git add --all
git commit -m "${pkg_name} md file"
git remote add origin_key https://${GITHUB_ACCESS_TOKEN}@github.com/MilanVasko/LuaDist2-Packages
git push origin_key master

