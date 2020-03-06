#!/bin/sh
# created by Mestafa Kamal

source tmp/deepspeech-kab-venv/bin/activate




# clean the TSVs
# Replace not alllowed letters
# Replace apostroph
# import_cv2 with alphabet filter
# Build allSentences.txt file from csv
# duplicate sentences containing "-"
# build language model
# Build Trie





# alphabet.txt contains the allowed letters in the wavs' transcipts. 
# Numbers are not allowed due to the non-possibility to transcript them into kabyle yet.


DeepSpeech/bin/import_cv2.py --filter_alphabet data-kab/alphabet.txt ./kab/

