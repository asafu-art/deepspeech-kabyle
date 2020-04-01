#! /usr/bin/env python
# created by Mestafa Kamal

import sys
import os
import shutil
import argparse
import csv
import text_cleaning as tc
from os import path
from tempfile import NamedTemporaryFile


if __name__ == "__main__":
    PARSER = argparse.ArgumentParser(description="Clean CSV files")
    PARSER.add_argument("--csv_dir", help="Directory containing tsv files", type=str)
    PARSER.add_argument(
        "--vocabulary_file", help="File containing all the corpus vocabulary", type=str
    )

    PARAMS = PARSER.parse_args()

    if PARAMS.csv_dir is not None:

        totalTreated = 0
        totalCleaned = 0
        totalStripped = 0

        if PARAMS.vocabulary_file is not None:
            vocabulary_out = path.abspath(PARAMS.vocabulary_file)
            print("Creating vocabulary file:", vocabulary_out)
            vocabulary = open(vocabulary_out, "wt", encoding="utf-8")
            vocab = True

        for dataset in ["train", "test", "dev", "validated", "other"]:
            fileTreated = 0
            fileCleanded = 0
            fileStripped = 0

            print("Directory:", path.abspath(PARAMS.csv_dir))
            input_csv = path.join(path.abspath(PARAMS.csv_dir), "csv", dataset + ".csv")
            if os.path.isfile(input_csv):
                print("Loading CSV file ", input_csv)

                temp_file = NamedTemporaryFile(mode="w", delete=False)
                fieldname = ["wav_filename", "wav_filesize", "transcript"]

                with open(
                    input_csv, "rt", encoding="utf-8"
                ) as input_csv_file, temp_file:
                    reader = csv.DictReader(input_csv_file, delimiter=",")
                    writer = csv.DictWriter(temp_file, fieldnames=fieldname)
                    writer.writeheader()
                    for row in reader:
                        sentence = row["transcript"]
                        cleanedSentence = tc.cleanSentence(sentence)

                        # Writing in vacabulary file
                        if dataset == "other":
                            if vocab:
                                vocabulary.write(cleanedSentence + "\n")

                            if sentence != cleanedSentence:
                                fileCleanded += 1
                                # print("S: ", sentence)
                                # print("CS:", cleanedSentence)
                            if cleanedSentence.__contains__("-") and vocab == True:
                                noTiretSentence = cleanedSentence.replace("-", " ")
                                # print("-S:", noTiretSentence)
                                fileStripped += 1
                                vocabulary.write(noTiretSentence + "\n")
                        writer.writerow(
                            {
                                "wav_filename": row["wav_filename"],
                                "wav_filesize": row["wav_filesize"],
                                "transcript": cleanedSentence,
                            }
                        )
                        fileTreated += 1

                    print("Treated sentences:", fileTreated)
                    totalTreated += fileTreated
                    print("File Cleanded sentences:", fileCleanded)
                    totalCleaned += fileCleanded
                    print("File Stripped sentences:", fileStripped)
                    totalStripped += fileStripped

                print("temp:", temp_file.name)
                input_csv_file.close()
                temp_file.close()
                shutil.move(temp_file.name, input_csv)

        print()
        print("Cleaning complete")
        print("Treated sentence:", totalTreated)
        print("Cleanded sentences:", totalCleaned)
        print("Stripped sentences:", totalStripped)
