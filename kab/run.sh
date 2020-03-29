#!/bin/sh
# created by Mestafa Kamal

set -xe

echo "Starting data pre-processing"

${MODEL_LANGUAGE}/pre_processing/a2_import_data_kab.sh

${MODEL_LANGUAGE}/a3_language_model.sh

echo "Data pre-processing complete"
