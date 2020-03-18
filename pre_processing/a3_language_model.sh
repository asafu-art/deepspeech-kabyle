#!/bin/sh
# created by Mestafa Kamal




# Build allSentences.txt file from csv
# duplicate sentences containing "-"
# build language model
# Build Trie




echo "Create language model"
pwd 

#source ../tmp/deepspeech-kab-venv/bin/activate

python3 ./Python/counter.py ../data-kab/allSentences.txt ../data-kab/top-words.txt 600000

#the path to kenlm/build/bin must be in PATH
echo "Starting lmpz..."

lmplz --text ../data-kab/allSentencesClean.txt --arpa ../data-kab/lm/words.arpa --o 3

echo "Filtering arpa file..."

filter single model:../data-kab/lm/words.arpa ../data-kab/lm/lm-kab-filtered.arpa < ../data-kab/top-words.txt
 
echo "Building lm binaries..."
build_binary -T -s ../data-kab/lm/lm-kab-filtered.arpa ../data-kab/lm/lm.binary

echo "Language model creation complete"

./native_client/generate_trie ../data_kab/alphabet.txt ../data_kab/lm/lm.binary ../data_kab/lm/trie



