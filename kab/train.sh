#!/bin/bash

echo "Check DeepSpeech"

pushd $DS_DIR

    all_train_csv="$(find $DATADIR/extracted/data/ -type f -name '*train.csv' -printf '%p,' | sed -e 's/,$//g')"
	all_dev_csv="$(find $DATADIR/extracted/data/ -type f -name '*dev.csv' -printf '%p,' | sed -e 's/,$//g')"
	all_test_csv="$(find $DATADIR/extracted/data/ -type f -name '*test.csv' -printf '%p,' | sed -e 's/,$//g')"

	mkdir -p $DATADIR/sources/feature_cache || true

	if [ ! -f "$DATADIR/checkpoints/best_dev_checkpoint" ]; then
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
				--lm_alpha ${LM_ALPHA} \
				--lm_beta ${LM_BETA} \
				${EARLY_STOP_FLAG} \
				--checkpoint_dir $DATADIR/checkpoints/
	fi;
	
	if [ ! -f "$DATADIR/models/output_graph.pb" ]; then
		python -u DeepSpeech.py \
			--alphabet_config_path $HOMEDIR/${MODEL_LANGUAGE}/data_kab/alphabet.txt \
			--lm_binary_path $DATADIR/lm/lm.binary \
			--lm_trie_path $DATADIR/lm/trie \
			--feature_cache $DATADIR/sources/feature_cache \
			--n_hidden ${N_HIDDEN} \
			--beam_width ${BEAM_WIDTH} \
			--lm_alpha ${LM_ALPHA} \
			--lm_beta ${LM_BETA} \
			${EARLY_STOP_FLAG} \
			--load "best" \
			--checkpoint_dir $DATADIR/checkpoints/ \
			--export_dir $DATADIR/models/ \
			--export_language "kab"
	fi;
	if [ ! -f "$DATADIR/models/output_graph.tflite" ]; then
		python -u DeepSpeech.py \
			--alphabet_config_path $HOMEDIR/${MODEL_LANGUAGE}/data_kab/alphabet.txt \
			--lm_binary_path $DATADIR/lm/lm.binary \
			--lm_trie_path $DATADIR/lm/trie \
			--feature_cache $DATADIR/sources/feature_cache \
			--n_hidden ${N_HIDDEN} \
			--beam_width ${BEAM_WIDTH} \
			--lm_alpha ${LM_ALPHA} \
			--lm_beta ${LM_BETA} \
			--load "best" \
			--checkpoint_dir $DATADIR/checkpoints/ \
			--export_dir $DATADIR/models/ \
			--export_tflite \
			--export_language "fra"
	fi;

	if [ ! -f "$DATADIR/models/kab-kab.zip" ]; then
		mkdir $DATADIR/models/kab-kab || rm $DATADIR/models/kab-kab/*
		python -u DeepSpeech.py \
			--alphabet_config_path $HOMEDIR/${MODEL_LANGUAGE}/data_kab/alphabet.txt \
			--lm_binary_path $DATADIR/lm/lm.binary \
			--lm_trie_path $DATADIR/lm/trie \
			--feature_cache $DATADIR/sources/feature_cache \
			--n_hidden ${N_HIDDEN} \
			--beam_width ${BEAM_WIDTH} \
			--lm_alpha ${LM_ALPHA} \
			--lm_beta ${LM_BETA} \
			--load "best" \
			--checkpoint_dir $DATADIR/checkpoints/ \
			--export_dir $DATADIR/models/kab-kab \
			--export_zip \
			--export_language "Kabyle (KAB)"
	fi;
	if [ ! -f "$DATADIR/models/output_graph.pbmm" ]; then
		./convert_graphdef_memmapped_format --in_graph=$DATADIR/models/output_graph.pb --out_graph=$DATADIR/models/output_graph.pbmm
	fi;

popd


