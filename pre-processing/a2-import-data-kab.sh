#!/bin/sh

source tmp/deepspeech-kab-venv/bin/activate


DeepSpeech/bin/import_cv2.py --filter_alphabet data-kab/alphabet.txt ./kab/
