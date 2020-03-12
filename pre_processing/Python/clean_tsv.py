# created by Mestafa Kamal

import sys
import os
import shutil
import argparse
import csv

from os import path


def replace(fich):
    fin = open(fich, "rt")
    data = fin.read()
    data = data.replace("ğ", "ǧ")
    data = data.replace("Ğ", "Ǧ")
    data = data.replace("γ", "ɣ")
    data = data.replace("Γ", "Ɣ")
    data = data.replace("ε", "ɛ")
    data = data.replace("σ", "ɛ")
    data = data.replace("Σ", "Ɛ")
    data = data.replace("ţţ", "tt")
    data = data.replace("ţ", "tt")
    data = data.replace("tttt", "tt")
    data = data.replace("ttt", "tt")
    fin.close()
    print(fich)
    fin = open(fich, "wt")
    fin.write(data)
    fin.close()


"""
if __name__ == "__main__":
    PARSER = argparse.ArgumentParser(description="Clean TSV files")
    PARSER.add_argument("--tsv_dir", help="Directory containing tsv files", type=str)
    PARAMS = PARSER.parse_args()
    # ALPHABET = Alphabet(PARAMS.filter_alphabet) if PARAMS.filter_alphabet else None

    if PARAMS.tsv_dir is not None:
        # for dataset in ["train", "test", "dev", "validated", "other"]:
        for dataset in ["dev_copy", "validated_copy"]:
            input_tsv = path.join(path.abspath(PARAMS.tsv_dir), dataset + ".tsv")
            if os.path.isfile(input_tsv):
                print("Loading TSV file ", input_tsv)
                # output_csv = path.join(audio_dir, os.path.split(input_tsv)[-1].replace('tsv', 'csv'))
                print("Saving new DeepSpeech-formatted CSV file to , output_csv")

                # Get audiofile path and transcript for each sentence in tsv
                samples = []
                with open(input_tsv, encoding="utf-8") as input_tsv_file:
                    reader = csv.DictReader(input_tsv_file, delimiter="\t")

                    i = 0
                    for row in reader:
                        sentence = row["sentence"]

                        print("S: ", sentence)
                        # cleanedSentence = text_cleaning.cleanSentence(sentence)
                        # print("CS:", cleanedSentence)
                        i += 1
                        if i == 100:
                            break
"""

"""
    try:
        os.mkdir("./ts/")
        print("Directory", str(os.getcwd()) + "/ts created for saving tsv")
    except:
        print("Directory", str(os.getcwd()) + "/tsv already exists!")
"""
# replace(sys.argv[1])

a = "Σelmeγ"
print(a)
a = a.lower()
print(a)
a = a.replace("σ", "ɛ")
a = a.replace("γ", "ɣ")
print(a)
