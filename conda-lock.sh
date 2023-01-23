#!/usr/bin/env bash

set -x

# This script generates a conda lock file for the environment
# yaml files in this directory.
#
# It depends upon conda-lock
#
#   mamba install -y -c conda-forge conda-lock
#
# you can recreate an environment from a conda lock file with:
#
#   conda env create -n <env> --file <lockfile>
#
# for example
#
# conda env create --name YOURENV --file conda-linux-64.lock

conda-lock --kind explicit -f environment.yml
set +x
