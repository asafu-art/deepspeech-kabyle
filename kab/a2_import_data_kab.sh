#!/bin/sh
# created by Mestafa Kamal

# This script launches the tsv cleaing program and imports the vocal corpus

set -xe
echo "Emport kabyle data"


# import_cv2 with alphabet filter
# back-up the CV files
# clean the CSVs
# Replace not allowed letters


# alphabet.txt contains the allowed letters in the wavs' transcipts plus some extra-letters.
# Numbers are not allowed due to the non-possibility to transcript them into kabyle yet.

pushd $DS_DIR

    CV_KAB="kab.tar.gz"
   
    if [ ! -f "$DATADIR/sources/kab.tar.gz" ]; then
		exit 1
	fi;


if [ ! -f "$DATADIR/extracted/data/cv_kab/clips/train.csv" ]; then
		mkdir -p $DATADIR/extracted/data/cv_kab/ || true

		tar -C $DATADIR/extracted/data/cv_kab/ -xf $DATADIR/sources/kab.tar.gz


		python bin/import_cv2.py ${IMPORT_AS_ENGLISH} --filter_alphabet $HOMEDIR/${MODEL_LANGUAGE}/data_kab/alphabet.txt $DATADIR/extracted/data/cv_kab/
	fi;
popd

echo "Clean csv files"

python3 ${MODEL_LANGUAGE}/Python/clean_csv.py --csv_dir $DATADIR/extracted/data/cv_kab/clips --vocabulary_file $DATADIR/extracted/data/cv_kab/cvSentences.txt
