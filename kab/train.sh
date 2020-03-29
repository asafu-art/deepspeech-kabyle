#!/bin/sh

echo "Check DeepSpeech"

pushd ./DeepSpeech/

if [ ! -f DeepSpeech.py ]; then
    echo "Please make sure you run this from DeepSpeech's top level directory."
    exit 1
fi;

echo "DeepSpeech all fit" 

Batch_size=96
N_hidden=2048
Epochs=60
Learning_rate=0.0001
Dropout=0.3
Lm_alpha=0.65
Lm_beta=1.45
Beam_width=500
Early_stop=1
Es_mean_th=0.5
Es_std_th=0.5
Report_count=10

# command to train

python3 -u DeepSpeech.py \
  --train_files ../kab/clips/train.csv \
  --dev_files ../kab/clips/dev.csv \
  --test_files ../kab/clips/test.csv \
  --train_batch_size $Batch_size \
  --dev_batch_size $Batch_size \
  --test_batch_size $Batch_size \
  --n_hidden $N_hidden \
  --epoch $Epochs \
  --early_stop $Early_stop \
  --estop_mean_thresh $Es_mean_th \
  --estop_std_thresh $Es_std_th \
  --dropout_rate $Dropout \
  --learning_rate $Learning_rate \
  --report_count $Report_count \
  --export_dir ../results/model_export/ \
  --checkpoint_dir ../results/checkout/ \

  --lm_binary_path ../data-kab/lm/lm.binary \
  --lm_trie_path /home/nvidia/DeepSpeech/data/alfred/trie \





python3 -u DeepSpeech.py \
  --train_files ../kab/clips/train.csv \
  --dev_files ../kab/clips/dev.csv \
  --test_files ../kab/clips/test.csv \
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

  --lm_binary_path ../data-kab/lm/lm.binary \
  --lm_trie_path /home/nvidia/DeepSpeech/data/alfred/trie \
  "$@"




python -u DeepSpeech.py \
  --train_files /home/nvidia/DeepSpeech/data/alfred/train/train.csv \
  --dev_files /home/nvidia/DeepSpeech/data/alfred/dev/dev.csv \
  --test_files /home/nvidia/DeepSpeech/data/alfred/test/test.csv \
  --train_batch_size 80 \
  --dev_batch_size 80 \
  --test_batch_size 40 \
  --n_hidden 375 \
  --epoch 33 \
  --validation_step 1 \
  --early_stop True \
  --earlystop_nsteps 6 \
  --estop_mean_thresh 0.1 \
  --estop_std_thresh 0.1 \
  --dropout_rate 0.22 \
  --learning_rate 0.00095 \
  --report_count 100 \
  --use_seq_length False \
  --export_dir /home/nvidia/DeepSpeech/data/alfred/results/model_export/ \
  --checkpoint_dir /home/nvidia/DeepSpeech/data/alfred/results/checkout/ \
  --decoder_library_path /home/nvidia/tensorflow/bazel-bin/native_client/libctc_decoder_with_kenlm.so \
  --alphabet_config_path /home/nvidia/DeepSpeech/data/alfred/alphabet.txt \
  --lm_binary_path /home/nvidia/DeepSpeech/data/alfred/lm.binary \
  --lm_trie_path /home/nvidia/DeepSpeech/data/alfred/trie \
  "$@"





# default 
./DeepSpeech.py \
  --train_files ../kab/clips/train.csv \
  --dev_files ../kab/clips/dev.csv \
  --test_files ../kab/clips/test.csv \
  --alphabet_config_path ../data_kab/alphabet.txt \
  --lm_trie_path ../data_kab/lm/trie \
  --lm_binary_path ../data_kab/lm/lm.binary \
  --test_batch_size 32 \
  --train_batch_size 32 \
  --dev_batch_size 32 \
  --epochs 2 \
  --learning_rate 0.001 \
  --dropout_rate 0.05 \
  --export_dir ../models/model_export \
  --checkpoint_dir ../models/checkpoint_dir


#test
deepspeech --model ./models/model_export/output_graph.pb --lm data_kab/lm/lm.binary --trie data_kab/lm/trie --audio ./kab/a.wav








