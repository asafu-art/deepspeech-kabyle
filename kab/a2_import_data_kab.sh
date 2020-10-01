#!/bin/bash
# created by Mestafa Kamal


set -xe
echo "Emport kabyle data"

if [ -z "${CV_RELEASE_FILENAME}" ]; then
	echo "Define a CV release"
	exit 1
fi;

pushd $DS_DIR


    if [ ! -f "/mnt/sources/${CV_RELEASE_FILENAME}" ]; then		
		exit 1
	fi;

	sha256=$(sha256sum --binary /mnt/sources/${CV_RELEASE_FILENAME} | awk '{ print $1 }')

	if [ "${sha256}" != "${CV_RELEASE_SHA256}" ]; then
		echo "Invalid Common Voice dataset"
		exit 1
	fi;

	if [ "${ENGLISH_COMPATIBLE}" = "1" ]; then
		IMPORT_AS_ENGLISH="--normalize"
	fi;

	if [ ! -f "/mnt/extracted/data/cv_kab/clips/train.csv" ]; then
		
		mkdir -p /mnt/extracted/data/cv_kab/ || true

		tar -C /mnt/extracted/data/cv_kab/ --strip-components=2 -xf /mnt/sources/${CV_RELEASE_FILENAME}

		if [ ${DUPLICATE_SENTENCE_COUNT} -gt 1 ]; then 
		
			create-corpora -d /mnt/extracted/corpora -f /mnt/extracted/data/cv_kab/validated.tsv -l kab -s ${DUPLICATE_SENTENCE_COUNT}

			mv /mnt/extracted/corpora/kab/*.tsv /mnt/extracted/data/cv_kab/
		
		fi;

		python bin/import_cv2.py \
		${IMPORT_AS_ENGLISH} \
		--filter_alphabet $HOMEDIR/${MODEL_LANGUAGE}/data_kab/alphabet.txt \
		${IMPORTERS_VALIDATE_LOCALE} \
		/mnt/extracted/data/cv_kab/
	fi;
popd
