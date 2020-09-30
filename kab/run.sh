#!/bin/sh
# created by Mestafa Kamal

set -xe

${MODEL_LANGUAGE}/params.sh

if [ -x "${MODEL_LANGUAGE}/metadata.sh" ]; then
	. ${MODEL_LANGUAGE}/metadata.sh
else
	echo "Please prepare metadata informations."
	exit 1
fi;


${MODEL_LANGUAGE}/a2_import_data_kab.sh

${MODEL_LANGUAGE}/a3_language_model.sh

${MODEL_LANGUAGE}/train.sh

${MODEL_LANGUAGE}/a4_evaluate_LM.sh