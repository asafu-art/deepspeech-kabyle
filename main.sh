#!/bin/sh

echo "Statring DeepSpeech Kabyle"
pwd

echo "Installing requirements..."

./a1_prepareEnvironment.sh

pushd pre_processing

./run.sh

popd

echo "Statring DeepSpeech training..."

#train.sh