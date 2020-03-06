# created by Mestafa Kamal

import sys


def replace(fich):
    fin = open(fich, "rt")
    data = fin.read()
    data = data.replace("ğ", "ǧ")
    data = data.replace("γ", "ɣ")
    data = data.replace("ε", "ɛ")
    fin.close()
    print(fich)
    fin = open(fich, "wt")
    fin.write(data)
    fin.close()


if __name__ == "__main__":
    replace(sys.argv[1])
