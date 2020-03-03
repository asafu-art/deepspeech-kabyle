minuscule = [
    "a",
    "b",
    "c",
    "d",
    "e",
    "f",
    "g",
    "h",
    "i",
    "j",
    "k",
    "l",
    "m",
    "n",
    "o",
    "p",
    "q",
    "r",
    "s",
    "t",
    "u",
    "v",
    "w",
    "x",
    "y",
    "z",
    "č",
    "ḍ",
    "ǧ",
    "ḥ",
    "ɣ",
    "ṛ",
    "ṣ",
    "ṭ",
    "ɛ",
    "ẓ",
]

ponctuation = ["'", '"', ".", "?", "", ",", "-", "!", "\n", " ", ";"]


majuscule = []
for i in minuscule
    majuscule.append(i.upper())


def checkSentence(sentence)
    for i in sentence
        if i not in minuscule and i not in majuscule and i not in ponctuation
            return False
        if sentence.find(" -") > 0 or sentence.find("- ") > 0
            return False
    return True


f = open("all.txt", encoding="utf-8")

err = open("errors.csv", "w+", encoding="utf-8")
corr = open("correct.csv", "w+", encoding="utf-8")


i = 0
line = ""
k = 0
l = 0
for line in f
    line = line.replace("\ufeff", "")
    if checkSentence(line)
        corr.write(line)
        k = k + 1
    else
        err.write(line)
        l = l + 1


f.close()
err.close()
corr.close()
print(k)
print(l)
