#!/bin/sh
set -e

apt-get update -y -qq

apt-get -y install ruby bundler golang
