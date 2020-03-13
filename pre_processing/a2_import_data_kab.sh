#!/bin/sh
# created by Mestafa Kamal

# This script launches the tsv cleaing program and imports the vocal corpus

source tmp/deepspeech-kab-venv/bin/activate



# import_cv2 with alphabet filter
# back-up the CV files
# clean the CSVs
# Replace not allowed letters
# Duplicate sentences containing the character "-"
# Produce the allSentences.txt files


# alphabet.txt contains the allowed letters in the wavs' transcipts plus some extra-letters.
# Numbers are not allowed due to the non-possibility to transcript them into kabyle yet.

pushd DeepSpeech/

bin/import_cv2.py --filter_alphabet ../data-kab/alphabet.txt ./kab/

popd

python3 pre_processing/Python/clean_csv.py --csv_dir kab/clips --vocabulary_file ./daya_kab/AllSentences.txt
