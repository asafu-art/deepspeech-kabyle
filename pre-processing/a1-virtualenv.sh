#!/bin/sh

echo "Create a virtual environnement"


#virtualenv -p python3 ./tmp/deepspeech-kab-venv

source ./tmp/deepspeech-train-venv/bin/activate


pushd ./DeepSpeech/


if [ ! -f DeepSpeech.py ]; then
    echo "Please make sure you run this from DeepSpeech's top level directory."
    exit 1
fi;


pip3 install -r requirements.txt

echo "Requirements install complete"

popd
