#!/bin/bash
# created by Mestafa Kamal


set -xe
echo "Emport kabyle data"

pushd $DS_DIR

    CV_KAB="kab.tar.gz"
   
    if [ ! -f "$DATADIR/sources/kab.tar.gz" ]; then
		exit 1
	fi;

if [ ! -f "$DATADIR/extracted/data/cv_kab/clips/train.csv" ]; then
		mkdir -p $DATADIR/extracted/data/cv_kab/ || true

		tar -C $DATADIR/extracted/data/cv_kab/ -xf $DATADIR/sources/kab.tar.gz

		if [ ${DUPLICATE_SENTENCE_COUNT} -gt 1 ]; then 
		
			create-corpora -d $DATADIR/extracted/corpora -f $DATADIR/extracted/data/cv_kab/validated.tsv -l kab -s ${DUPLICATE_SENTENCE_COUNT}
			
			mv $DATADIR/extracted/corpora/kab/*.tsv $DATADIR/extracted/data/cv_kab/
		
		fi;

		python bin/import_cv2.py ${IMPORT_AS_ENGLISH} --filter_alphabet $HOMEDIR/${MODEL_LANGUAGE}/data_kab/alphabet.txt $DATADIR/extracted/data/cv_kab/
	fi;
popd

echo "Get unused cv sentences"

python3 ${MODEL_LANGUAGE}/Python/clean_tsv.py --tsv_dir $DATADIR/extracted/data/cv_kab --vocabulary_file $DATADIR/extracted/data/cv_kab/cvSentences.txt
