#!/bin/bash

set -xe






if [ ! -f "/mnt/lm/lm.binary" ]; then

		wget https://raw.githubusercontent.com/mozillakab/Kabyletexts/master/lm/Aklanntayri.pdf.bis.txt -P /mnt/extracted/data/cv_kab/

		wget https://raw.githubusercontent.com/mozillakab/Kabyletexts/master/lm/Amakrad.pdf.bis.txt -P /mnt/extracted/data/cv_kab/

		wget https://raw.githubusercontent.com/mozillakab/Kabyletexts/master/lm/Amezgun.pdf.bis.txt -P /mnt/extracted/data/cv_kab/

		wget https://raw.githubusercontent.com/mozillakab/Kabyletexts/master/lm/Amtmeqquntntzeggigin.pdf.bis.txt -P /mnt/extracted/data/cv_kab/

		wget https://raw.githubusercontent.com/mozillakab/Kabyletexts/master/lm/Anzaren.pdf.bis.txt -P /mnt/extracted/data/cv_kab/

		wget https://raw.githubusercontent.com/mozillakab/Kabyletexts/master/lm/Azalntayri.pdf.bis.txt -P /mnt/extracted/data/cv_kab/

		wget https://raw.githubusercontent.com/mozillakab/Kabyletexts/master/lm/Djoher-Amhis-Ouksel-Inig-akked-ccfaya.pdf.bis.txt -P /mnt/extracted/data/cv_kab/

		wget https://raw.githubusercontent.com/mozillakab/Kabyletexts/master/lm/Habib-Allah-Mansouri-Tighermin-yemmeccen.pdf.bis.txt -P /mnt/extracted/data/cv_kab/

		wget https://raw.githubusercontent.com/mozillakab/Kabyletexts/master/lm/Trad-n-Yugurten-Traduc-M.O-Kheddam.pdf.bis.txt -P /mnt/extracted/data/cv_kab/

		wget https://raw.githubusercontent.com/mozillakab/Kabyletexts/master/lm/aberrani.txt -P /mnt/extracted/data/cv_kab/

		wget https://raw.githubusercontent.com/mozillakab/Kabyletexts/master/lm/abucidan.txt -P /mnt/extracted/data/cv_kab/

		wget https://raw.githubusercontent.com/mozillakab/Kabyletexts/master/lm/imedyazen.txt -P /mnt/extracted/data/cv_kab/

		wget https://raw.githubusercontent.com/mozillakab/Kabyletexts/master/lm/isefra.txt -P /mnt/extracted/data/cv_kab/

		wget https://raw.githubusercontent.com/mozillakab/Kabyletexts/master/lm/wiki.kab.txt -P /mnt/extracted/data/cv_kab/

		wget https://raw.githubusercontent.com/MestafaKamal/kabyle-language-data/master/tatoebaSentences.txt -P /mnt/extracted/data/cv_kab/

		cat /mnt/extracted/data/cv_kab/Aklanntayri.pdf.bis.txt \
		/mnt/extracted/data/cv_kab/Amakrad.pdf.bis.txt \
		/mnt/extracted/data/cv_kab/Amezgun.pdf.bis.txt \
		/mnt/extracted/data/cv_kab/Amtmeqquntntzeggigin.pdf.bis.txt \
		/mnt/extracted/data/cv_kab/Anzaren.pdf.bis.txt \
		/mnt/extracted/data/cv_kab/Azalntayri.pdf.bis.txt \
		/mnt/extracted/data/cv_kab/Djoher-Amhis-Ouksel-Inig-akked-ccfaya.pdf.bis.txt \
		/mnt/extracted/data/cv_kab/Habib-Allah-Mansouri-Tighermin-yemmeccen.pdf.bis.txt \
		/mnt/extracted/data/cv_kab/Trad-n-Yugurten-Traduc-M.O-Kheddam.pdf.bis.txt \
		/mnt/extracted/data/cv_kab/aberrani.txt \
		/mnt/extracted/data/cv_kab/abucidan.txt \
		/mnt/extracted/data/cv_kab/imedyazen.txt \
		/mnt/extracted/data/cv_kab/isefra.txt \
		/mnt/extracted/data/cv_kab/wiki.kab.txt \
		/mnt/extracted/data/cv_kab/tatoebaSentences.txt \
		/mnt/extracted/data/cv_kab/cvSentences.txt > /mnt/extracted/data/cv_kab/allSentences.txt

