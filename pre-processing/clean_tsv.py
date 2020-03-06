import sys


def replace(fich):
    fin = open(fich, "rt")
    data = fin.read()
    data = data.replace("ğ", "ǧ")
    fin.close()
    print(fich)
    fin = open(fich, "wt")
    fin.write(data)
    fin.close()


if __name__ == "__main__":
    replace(sys.argv[1])
