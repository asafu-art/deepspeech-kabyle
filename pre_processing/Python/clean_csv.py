#! /usr/bin/env python
# created by Mestafa Kamal

import sys
import os
import shutil
import argparse
import csv
import text_cleaning as tc
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


if __name__ == "__main__":
    PARSER = argparse.ArgumentParser(description="Clean CSV files")
    PARSER.add_argument("--csv_dir", help="Directory containing tsv files", type=str)
    PARAMS = PARSER.parse_args()
    # ALPHABET = Alphabet(PARAMS.filter_alphabet) if PARAMS.filter_alphabet else None

    if PARAMS.csv_dir is not None:
        index = 0
        index1 = 0
        for dataset in ["train", "test", "dev", "validated", "other"]:
            # for dataset in ["other"]:
            input_csv = path.join(path.abspath(PARAMS.csv_dir), dataset + ".csv")
            if os.path.isfile(input_csv):
                print("Loading CSV file ", input_csv)
                # output_csv = path.join(audio_dir, os.path.split(input_tsv)[-1].replace('tsv', 'csv'))
                # print("Saving new DeepSpeech-formatted CSV file to , output_csv")

                # Get audiofile path and transcript for each sentence in tsv
                # samples = []
                with open(input_csv, encoding="utf-8") as input_csv_file:
                    reader = csv.DictReader(input_csv_file, delimiter=",")
                    i = 0
                    for row in reader:
                        sentence = row["transcript"]
                        cleanedSentence = tc.cleanSentence(sentence)
                        if sentence != cleanedSentence:
                            index += 1
                            print("S: ", sentence)
                            print("CS:", cleanedSentence)
                            if cleanedSentence.__contains__("-"):
                                index1 += 1
                                noTiretSentence = cleanedSentence.replace("-", " ")
                                print("-S:", noTiretSentence)
                        i += 1
                        if i == 3000:
                            # break
                            pass
                    print(i)
                input_csv_file.close()
        print(index, "sentences cleaned")
        print(index1, "sentences stripped")


"""
    try:
        os.mkdir("./ts/")
        print("Directory", str(os.getcwd()) + "/ts created for saving tsv")
    except:
        print("Directory", str(os.getcwd()) + "/tsv already exists!")
"""
# replace(sys.argv[1])
