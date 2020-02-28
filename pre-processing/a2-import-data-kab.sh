#!/bin/sh

source tmp/deepspeech-kab-venv/bin/activate

echo "Create language model"

python3 pre-processing/counter.py data-kab/allSentencesClean.txt data-kab/top-words.txt 600000

#the path to kenlm/build/bin must be in PATH

lmplz --text data-kab/allSentencesClean.txt --arpa data-kab/lm/words.arpa --o 3

filter single model:./data-kab/lm/words.arpa ./data-kab/lm/lm-kab-filtered.arpa < ./data-kab/top-words.txt
 
build_binary -T -s ./data-kab/lm/lm-kab-filtered.arpa ./lm/data-kab/lm.binary

echo "Language model creation complete"
