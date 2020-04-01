#!/bin/bash

echo "Check DeepSpeech"

pushd $DS_DIR

    all_train_csv="$(find $DATADIR/extracted/data/ -type f -name '*train.csv' -printf '%p,' | sed -e 's/,$//g')"
	all_dev_csv="$(find $DATADIR/extracted/data/ -type f -name '*dev.csv' -printf '%p,' | sed -e 's/,$//g')"
	all_test_csv="$(find $DATADIR/extracted/data/ -type f -name '*test.csv' -printf '%p,' | sed -e 's/,$//g')"

EARLY_STOP_FLAG="--early_stop"
		if [ "${EARLY_STOP}" = "0" ]; then
			EARLY_STOP_FLAG="--noearly_stop"
		fi;



python -u DeepSpeech.py \
			--show_progressbar True \
			--use_cudnn_rnn True \
			--automatic_mixed_precision True \
			--alphabet_config_path $HOMEDIR/${MODEL_LANGUAGE}/data_kab/alphabet.txt \
			--lm_binary_path $DATADIR/lm/lm.binary \
			--lm_trie_path $DATADIR/lm/trie \			
			--train_files ${all_train_csv} \
			--dev_files ${all_dev_csv} \
			--test_files ${all_test_csv} \			
			--train_batch_size ${BATCH_SIZE} \
			--dev_batch_size ${BATCH_SIZE} \
			--test_batch_size ${BATCH_SIZE} \
			--n_hidden ${N_HIDDEN} \
			--epochs ${EPOCHS} \
			--learning_rate ${LEARNING_RATE} \
			--dropout_rate ${DROPOUT} \
			${EARLY_STOP_FLAG} \
			--checkpoint_dir $DATADIR/checkpoints\
			--export_dir .$DATADIR/models/model_export/

popd


