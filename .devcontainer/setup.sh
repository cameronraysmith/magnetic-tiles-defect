#!/usr/bin/env bash

set -x

# debian packages
sudo apt-get install -y \
time

# conda environment
mamba env create -f environment.yml || mamba env update -f environment.yml
mamba clean -yaf

# pypi
pipx install conda-lock
pip install --user -r requirements.txt

# data 
python -m dvc pull

set +x
