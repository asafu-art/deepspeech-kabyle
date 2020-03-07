# created by Mestafa Kamal

import sys
import os
import shutil


def replace(fich):
    fin = open(fich, "rt")
    data = fin.read()
    data = data.replace("ğ", "ǧ")
    data = data.replace("Ğ", "Ǧ")
    data = data.replace("γ", "ɣ")
    data = data.replace("Γ", "Ɣ")
    data = data.replace("ε", "ɛ")
    data = data.replace("Σ", "Ɛ")
    fin.close()
    print(fich)
    fin = open(fich, "wt")
    fin.write(data)
    fin.close()


if __name__ == "__main__":
    try:
        os.mkdir("./ts/")
        print("Directory", str(os.getcwd()) + "/ts created for saving tsv")
    except:
        print("Directory", str(os.getcwd()) + "/tsv already exists!")
    # replace(sys.argv[1])

