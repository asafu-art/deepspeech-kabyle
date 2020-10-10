#!/bin/bash
# created by Mestafa Kamal


set -xe
echo "Emport Kabyle Tatoeba data"


pushd $DS_DIR

	if [ "${ENGLISH_COMPATIBLE}" = "1" ]; then
		IMPORT_AS_ENGLISH="--normalize"
	fi;

	if [ ! -f "/mnt/extracted/data/tatoeba/clips/train.csv" ]; then
		
		mkdir -p /mnt/extracted/data/tatoeba/ || true

		if [ ${DUPLICATE_SENTENCE_COUNT} -gt 1 ]; then 
		
			create-corpora -d /mnt/extracted/corpora -f /mnt/extracted/data/tatoeba/validated.tsv -l kab -s ${DUPLICATE_SENTENCE_COUNT}

			mv /mnt/extracted/corpora/kab/*.tsv /mnt/extracted/data/tatoeba/
		
		fi;

		python bin/import_cv2.py \
		${IMPORT_AS_ENGLISH} \
		--filter_alphabet $HOMEDIR/${MODEL_LANGUAGE}/data_kab/alphabet.txt \
		${IMPORTERS_VALIDATE_LOCALE} \
		/mnt/extracted/data/tatoeba/
	fi;
popd
