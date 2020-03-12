# created by Mestafa Kamal

# source ../tmp/deepspeech-kab-venv/bin/activate

# python3 prog.py tsv/

import os
import csv
import argparse

import text_cleaning

from os import path

# from util.text import Alphabet

if __name__ == "__main__":
    PARSER = argparse.ArgumentParser(description="Clean text corpus")
    PARSER.add_argument("--tsv_dir", help="Directory containing tsv files", type=str)
    PARSER.add_argument("--output_file", help="File containing all sentences", type=str)
    PARSER.add_argument(
        "--filter_alphabet",
        help="Exclude samples with characters not in provided alphabet",
        type=str,
    )
    PARAMS = PARSER.parse_args()
    # ALPHABET = Alphabet(PARAMS.filter_alphabet) if PARAMS.filter_alphabet else None

    if PARAMS.tsv_dir is not None:
        for dataset in ["train", "test", "dev", "validated", "other"]:
            input_tsv = path.join(path.abspath(PARAMS.tsv_dir), dataset + ".csv")
            if os.path.isfile(input_tsv):
                print("Loading TSV file ", input_tsv)
                # output_csv = path.join(audio_dir, os.path.split(input_tsv)[-1].replace('tsv', 'csv'))
                print("Saving new DeepSpeech-formatted CSV file to , output_csv")

                # Get audiofile path and transcript for each sentence in tsv
                samples = []
                with open(input_tsv, encoding="utf-8") as input_tsv_file:
                    reader = csv.DictReader(input_tsv_file, delimiter=",")
                    i = 0
                    for row in reader:
                        sentence = row["transcript"]

                        print("S: ", sentence)
                        cleanedSentence = text_cleaning.cleanSentence(sentence)
                        print("CS:", cleanedSentence)
                        i += 1
                        if i == 100:
                            break
                        # samples.append((row['path'], row['sentence']))

