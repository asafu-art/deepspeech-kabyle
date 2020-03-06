#!/bin/sh
# created by Mestafa Kamal

# This script create a Python3 virtual environment 
# in which the requirements are installs so that the project can be executed.

echo "Create a virtual environnement"


#virtualenv -p python3 ./tmp/deepspeech-kab-venv

source ./tmp/deepspeech-kab-venv/bin/activate


pushd ../DeepSpeech/


if [ ! -f DeepSpeech.py ]; then
    echo "Please make sure you run this from DeepSpeech's top level directory."
    exit 1
fi;

pip3 install -r requirements.txt

echo "Requirements install complete"

popd

git clone https://github.com/kpu/kenlm.git
pushd kenlm/
mkdir -p build
pushd build/
cmake ..
make -j2

popd
popd
