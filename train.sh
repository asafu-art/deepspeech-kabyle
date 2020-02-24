#!/bin/sh

echo "Check DeepSpeech"

if [ ! -f DeepSpeech.py ]; then
    echo "Please make sure you run this from DeepSpeech's top level directory."
    exit 1
fi;

echo "DeepSpeech all fit" 

python3 -u DeepSpeech.py \
  --train_files ../data/kab/clips/train.csv \
  --dev_files ../data/kab/clips/dev.csv \
  --test_files ../data/kab/clips/test.csv \
  --train_batch_size 1 \
  --dev_batch_size 1 \
  --test_batch_size 1 \
  --n_hidden 375 \
  --epoch 75 \
  --early_stop True \
  --estop_mean_thresh 0.5 \
  --estop_std_thresh 0.5 \
  --dropout_rate 0.05 \
  --learning_rate 0.001 \
  --report_count 10 \
  --export_dir ../results/model_export/ \
  --checkpoint_dir ../results/checkout/ \

  --lm_binary_path /home/nvidia/DeepSpeech/data/alfred/lm.binary \
  --lm_trie_path /home/nvidia/DeepSpeech/data/alfred/trie \
  "$@"
