#!/bin/bash
# created by Mestafa Kamal


# build language model
# Build Trie


set -xe

echo "Create language model"

pushd $DATADIR/extracted

if [ ! -f "$DATADIR/lm/lm.binary" ]; then
		
		wget https://raw.githubusercontent.com/MestafaKamal/kabyle-language-data/master/tatoebaSentences.txt -P $DATADIR/extracted/data/cv_kab/
		
		cat $DATADIR/extracted/data/cv_kab/cvSentences.txt $DATADIR/extracted/data/cv_kab/tatoebaSentences.txt > $DATADIR/extracted/data/cv_kab/allSentences.txt

		python $HOMEDIR/counter.py $DATADIR/extracted/data/cv_kab/allSentences.txt $DATADIR/extracted/data/cv_kab/top_words.txt 500000

		lmplz	--order 4 \
			--temp_prefix $DATADIR/tmp/ \
			--text $DATADIR/extracted/data/cv_kab/allSentences.txt \
			--arpa $DATADIR/lm/kab_words.arpa \
			--skip_symbols 
			--prune 0 0 1

		filter single model:$DATADIR/lm/kab_words.arpa $DATADIR/lm/lm_kab_filtered.arpa < $DATADIR/extracted/data/cv_kab/top_words.txt

		build_binary -a 255 \
			-q 8 \
            trie \
			$DATADIR/lm/lm_kab_filtered.arpa \
			$DATADIR/lm/lm.binary		
	fi;
    if [ ! -f "$DATADIR/lm/trie" ]; then	
		$DS_DIR/native_client/generate_trie $HOMEDIR/${MODEL_LANGUAGE}/data_kab/alphabet.txt $DATADIR/lm/lm.binary $DATADIR/lm/trie
	fi;


popd

