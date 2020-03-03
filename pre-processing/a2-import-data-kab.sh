#!/bin/sh

source tmp/deepspeech-kab-venv/bin/activate


# alphabet.txt contains the allowed letters in the wavs' transcipts. 
# Numbers are not allowed due to the non-possibility to transcript them into kabyle yet.


DeepSpeech/bin/import_cv2.py --filter_alphabet data-kab/alphabet.txt ./kab/
