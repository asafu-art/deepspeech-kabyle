#!/bin/sh
# created by Mestafa Kamal

# This script create a Python3 virtual environment 
# in which the requirements are installed so that the project can be executed.

echo "Creating a virtual environment"
pwd

#virtualenv -p python3 ../tmp/deepspeech-kab-venv

echo "Activating the virtual environment"
#source ../tmp/deepspeech-kab-venv/bin/activate



pushd ./DeepSpeech/



if [ ! -f DeepSpeech.py ]; then
    echo "Please make sure you run this from DeepSpeech's top level directory."
    exit 1
fi;

echo "Installing DeepSpeech requirements"
pwd 
#pip3 install -r ./requirements.txt

echo "DeepSpeech Requirements install complete"

popd

echo "Installing pre-processing requirements"
#pip3 install -r ./pre_processing/requirements.txt
echo "Pre-processing requirements install complete"

echo "Installing kenlm"
pwd

echo "Cloning kenlm"
# git clone https://github.com/kpu/kenlm.git ./kenlm

#pushd ./kenlm/
echo "Building kenlm"
# mkdir -p build

echo "Make kenlm"
#pushd ./build/
# cmake ..
# make -j2
#popd 
#popd

echo "Downloading Common Voice kabyle corpus"
# wget https://voice-prod-bundler-ee1969a6ce8178826482b88e843c335139bd3fb4.s3.amazonaws.com/cv-corpus-4-2019-12-10/kab.tar.gz

pwd
