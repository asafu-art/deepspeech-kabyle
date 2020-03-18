#!/bin/sh
# created by Mestafa Kamal

# This script launches the tsv cleaing program and imports the vocal corpus

echo "Emport kabyle data"

# source tmp/deepspeech-kab-venv/bin/activate



# import_cv2 with alphabet filter
# back-up the CV files
# clean the CSVs
# Replace not allowed letters
# Duplicate sentences containing the character "-"
# Produce the allSentences.txt files


# alphabet.txt contains the allowed letters in the wavs' transcipts plus some extra-letters.
# Numbers are not allowed due to the non-possibility to transcript them into kabyle yet.

pushd ../DeepSpeech/

if [ ! -f DeepSpeech.py ]; then
    echo "Please make sure you run this from DeepSpeech's top level directory."
    exit 1
fi;

echo "Emport Deepspeech cv2"
pwd 
bin/import_cv2.py --filter_alphabet ../data-kab/alphabet.txt ./kab/

popd

echo "Clean csv files"
pwd

python3 ./Python/clean_csv.py --csv_dir ../kab/clips --vocabulary_file ../data_kab/allSentences.txt
