#!/bin/bash
# created by Mestafa Kamal


# build language model
# Build Trie


set -xe

echo "Create language model"

pushd $DATADIR/extracted

if [ ! -f "$DATADIR/lm/lm.binary" ]; then

		wget https://raw.githubusercontent.com/mozillakab/Kabyletexts/master/lm/Aklanntayri.pdf.bis.txt -P $DATADIR/extracted/data/cv_kab/

		wget https://raw.githubusercontent.com/mozillakab/Kabyletexts/master/lm/Amakrad.pdf.bis.txt -P $DATADIR/extracted/data/cv_kab/

		wget https://raw.githubusercontent.com/mozillakab/Kabyletexts/master/lm/Amezgun.pdf.bis.txt -P $DATADIR/extracted/data/cv_kab/

		wget https://raw.githubusercontent.com/mozillakab/Kabyletexts/master/lm/Amtmeqquntntzeggigin.pdf.bis.txt -P $DATADIR/extracted/data/cv_kab/

		wget https://raw.githubusercontent.com/mozillakab/Kabyletexts/master/lm/Anzaren.pdf.bis.txt -P $DATADIR/extracted/data/cv_kab/

		wget https://raw.githubusercontent.com/mozillakab/Kabyletexts/master/lm/Azalntayri.pdf.bis.txt -P $DATADIR/extracted/data/cv_kab/

		wget https://raw.githubusercontent.com/mozillakab/Kabyletexts/master/lm/Djoher-Amhis-Ouksel-Inig-akked-ccfaya.pdf.bis.txt -P $DATADIR/extracted/data/cv_kab/

		wget https://raw.githubusercontent.com/mozillakab/Kabyletexts/master/lm/Habib-Allah-Mansouri-Tighermin-yemmeccen.pdf.bis.txt -P $DATADIR/extracted/data/cv_kab/

		wget https://raw.githubusercontent.com/mozillakab/Kabyletexts/master/lm/Trad-n-Yugurten-Traduc-M.O-Kheddam.pdf.bis.txt -P $DATADIR/extracted/data/cv_kab/

		wget https://raw.githubusercontent.com/mozillakab/Kabyletexts/master/lm/aberrani.txt -P $DATADIR/extracted/data/cv_kab/

		wget https://raw.githubusercontent.com/mozillakab/Kabyletexts/master/lm/abucidan.txt -P $DATADIR/extracted/data/cv_kab/

		wget https://raw.githubusercontent.com/mozillakab/Kabyletexts/master/lm/imedyazen.txt -P $DATADIR/extracted/data/cv_kab/

		wget https://raw.githubusercontent.com/mozillakab/Kabyletexts/master/lm/isefra.txt -P $DATADIR/extracted/data/cv_kab/

		wget https://raw.githubusercontent.com/mozillakab/Kabyletexts/master/lm/wiki.kab.txt -P $DATADIR/extracted/data/cv_kab/

		wget https://raw.githubusercontent.com/MestafaKamal/kabyle-language-data/master/tatoebaSentences.txt -P $DATADIR/extracted/data/cv_kab/

		cat $DATADIR/extracted/data/cv_kab/Aklanntayri.pdf.bis.txt $DATADIR/extracted/data/cv_kab/Amakrad.pdf.bis.txt $DATADIR/extracted/data/cv_kab/Amezgun.pdf.bis.txt $DATADIR/extracted/data/cv_kab/Amtmeqquntntzeggigin.pdf.bis.txt $DATADIR/extracted/data/cv_kab/Anzaren.pdf.bis.txt $DATADIR/extracted/data/cv_kab/Azalntayri.pdf.bis.txt $DATADIR/extracted/data/cv_kab/Djoher-Amhis-Ouksel-Inig-akked-ccfaya.pdf.bis.txt $DATADIR/extracted/data/cv_kab/Habib-Allah-Mansouri-Tighermin-yemmeccen.pdf.bis.txt $DATADIR/extracted/data/cv_kab/Trad-n-Yugurten-Traduc-M.O-Kheddam.pdf.bis.txt $DATADIR/extracted/data/cv_kab/aberrani.txt $DATADIR/extracted/data/cv_kab/abucidan.txt $DATADIR/extracted/data/cv_kab/imedyazen.txt $DATADIR/extracted/data/cv_kab/isefra.txt $DATADIR/extracted/data/cv_kab/wiki.kab.txt $DATADIR/extracted/data/cv_kab/tatoebaSentences.txt $DATADIR/extracted/data/cv_kab/cvSentences.txt > $DATADIR/extracted/data/cv_kab/allSentences.txt

		python $HOMEDIR/counter.py $DATADIR/extracted/data/cv_kab/allSentences.txt $DATADIR/extracted/data/cv_kab/top_words.txt 500000

		lmplz	--order 4 \
			--temp_prefix $DATADIR/tmp/ \
			--memory 80% \
			--text $DATADIR/extracted/data/cv_kab/allSentences.txt \
			--arpa $DATADIR/lm/kab_words.arpa \
			--skip_symbols \
			--prune 0 0 1

		filter single model:$DATADIR/lm/kab_words.arpa $DATADIR/lm/lm_kab_filtered.arpa < $DATADIR/extracted/data/cv_kab/top_words.txt

		build_binary -a 255 \
			-q 8 \
			trie \
			-T \
			-s \
			$DATADIR/lm/lm_kab_filtered.arpa \
			$DATADIR/lm/lm.binary		
	fi;
    if [ ! -f "$DATADIR/lm/trie" ]; then	
		$DS_DIR/native_client/generate_trie $HOMEDIR/${MODEL_LANGUAGE}/data_kab/alphabet.txt $DATADIR/lm/lm.binary $DATADIR/lm/trie
	fi;


popd

