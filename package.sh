#!/bin/bash

set -xe

pushd /$DATADIR

    if [ ! -f "model_tensorflow_kab.tar.xz" ]; then
            tar -cf - \
                -C $DATADIR/models/ output_graph.pbmm  \
                -C $HOMEDIR/${MODEL_LANGUAGE}/data_kab/ alphabet.txt \
                -C $DATADIR/lm/ lm.binary trie | xz -T0 > model_tensorflow_kab.tar.xz
        fi;

        if [ ! -f "model_tflite_kab.tar.xz" ]; then
            tar -cf - \
                -C $DATADIR/models/ output_graph.tflite \
                -C $HOMEDIR/${MODEL_LANGUAGE}/data_kab/ alphabet.txt \
                -C $DATADIR/lm/ lm.binary trie | xz -T0 > model_tflite_kab.tar.xz
        fi;
        
        if [ ! -f "checkpoint_kab.tar.xz" ]; then
            all_checkpoint_path=""
            for ckpt in $(grep '^model_checkpoint_path:' checkpoints/best_dev_checkpoint | cut -d'"' -f2);
            do
                ckpt_file=$(basename "${ckpt}")
                for f in $(find checkpoints/ -type f -name "${ckpt_file}.*");
                do
                    ckpt_to_add=$(basename "${f}")
                    all_checkpoint_path="${all_checkpoint_path} ${ckpt_to_add}"
                done;
            done;
        
            tar -cf - \
                -C $DATADIR/checkpoints/ checkpoint ${all_checkpoint_path} | xz -T0 > "checkpoint_kab.tar.xz"
        fi;

        cp $DATADIR/models/*.zip .
popd