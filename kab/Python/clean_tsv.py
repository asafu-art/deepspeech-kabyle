#! /usr/bin/env python
# created by Mestafa Kamal

import sys
import os
import argparse
import csv
import text_cleaning as tc
from os import path
from tempfile import NamedTemporaryFile


if __name__ == "__main__":
    PARSER = argparse.ArgumentParser(description="Clean CSV files")
    PARSER.add_argument("--tsv_dir", help="Directory containing tsv files", type=str)
    PARSER.add_argument(
        "--vocabulary_file", help="File containing all the corpus vocabulary", type=str
    )

    PARAMS = PARSER.parse_args()

    if PARAMS.tsv_dir is not None:

        totalTreated = 0
        totalCleaned = 0
        totalStripped = 0

        if PARAMS.vocabulary_file is not None:
            vocabulary_out = path.abspath(PARAMS.vocabulary_file)
            print("Creating vocabulary file:", vocabulary_out)
            vocabulary = open(vocabulary_out, "wt", encoding="utf-8")
            vocab = True

        for dataset in [ "invalidated", "other"]:
            fileTreated = 0
            fileCleanded = 0
            fileStripped = 0

            print("Directory:", path.abspath(PARAMS.tsv_dir))
            input_tsv = path.join(path.abspath(PARAMS.tsv_dir), dataset + ".tsv")
            if os.path.isfile(input_tsv):
                print("Loading TSV file ", input_tsv)


                with open(
                    input_tsv, "rt", encoding="utf-8"
                ) as input_tsv_file:
                    reader = csv.DictReader(input_tsv_file, delimiter="\t")
                              
                    for row in reader:
                        sentence = row["sentence"]
                        cleanedSentence = tc.cleanSentence(sentence)

                        # Writing in vacabulary file
                        
                        if vocab:
                            vocabulary.write(cleanedSentence + "\n")

                        #print("S :", sentence)
                        if sentence != cleanedSentence:
                            fileCleanded += 1                            
                            #print("CS:", cleanedSentence)
                        if cleanedSentence.__contains__("-") and vocab == True:
                            noTiretSentence = cleanedSentence.replace("-", " ")
                            #print("-S:", noTiretSentence)
                            fileStripped += 1
                            vocabulary.write(noTiretSentence + "\n")
                    
                        fileTreated += 1                        

                    print("Treated sentences:", fileTreated)
                    totalTreated += fileTreated
                    print("File Cleanded sentences:", fileCleanded)
                    totalCleaned += fileCleanded
                    print("File Stripped sentences:", fileStripped)
                    totalStripped += fileStripped                
                input_tsv_file.close()            

        """
        print()
        print("Cleaning complete")
        print("Treated sentence:", totalTreated)
        print("Cleanded sentences:", totalCleaned)
        print("Stripped sentences:", totalStripped)
        """