#!/usr/bin/env bash

BUILD_DIR="${WORKSPACE}/build/"

rm -rf "${BUILD_DIR}"
mkdir -p "${BUILD_DIR}"

bundle install --path "${HOME}/bundles/${JOB_NAME}"

cd "recipes/${RECIPE_NAME}/"

bundle exec fpm-cook --target deb

cp pkg/*.deb "${BUILD_DIR}"
