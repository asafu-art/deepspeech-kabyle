#!/bin/sh
# created by Mestafa Kamal

set -xe


${MODEL_LANGUAGE}/a2_import_data_kab.sh

${MODEL_LANGUAGE}/a3_language_model.sh

${MODEL_LANGUAGE}/train.sh

${MODEL_LANGUAGE}/a4_evaluate_LM.sh