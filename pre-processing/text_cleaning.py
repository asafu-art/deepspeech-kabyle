import string
import collections

allowed = list(string.ascii_lowercase)
allowed.append("-")
allowed.extend(list("ẓṛṭɛṣḍǧḥɣč"))


replacer = {
    "àáâãåāăąǟǡǻȁȃȧâä": "a",
    "ǣǽ": "æ",
    "çćĉċ": "c",
    "ďđ": "d",
    "èéêëēĕėęěȅȇȩîêë": "e",
    "ĝġģǥǵ": "g",
    "ğ": "ǧ",
    "ĥħȟ": "h",
    "ìíîïĩīĭįıȉȋîï": "i",
    "ĵǰ": "j",
    "ķĸǩǩκ": "k",
    "ĺļľŀł": "l",
    "м": "m",
    "ñńņňŉŋǹ": "n",
    "òóôõøōŏőǫǭǿȍȏðοöô": "o",
    "ŕŗřȑȓ": "r",
    "śŝşšș": "s",
    "ţťŧț": "t",
    "ùúûũūŭůűųȕȗüû": "u",
    "ŵ": "w",
    "ýÿŷ": "y",
    "źżžȥ": "z",
    "ß": "ss",
}

punctuation = ["'", '"', ".", "?", ",", "!", ";"]

replacements = {}

for all, replacement in replacer.items():
    for to_replace in all:
        replacements[to_replace] = replacement

print(allowed)


def remplaceSymbols(word):
    result = word
    for to_replace, replacement in replacements.items():
        result = result.replace(to_replace, replacement)

    return result


def removeSymbols(word):
    return word


def cleanWord(word):
    word = word.lower()
    word = remplaceSymbols(word)
    word = removeSymbols(word)
    return word


def cleanSentence(sentence):

    sentence = sentence.strip()
    sentence = sentence.lower()
    sentence = remplaceSymbols(sentence)

    words = sentence.strip().split(" ")
    # print(words)
    cleanedWords = []
    for word in words:
        word = cleanWord(word)
        if word.__contains__("a"):
            print(word)
        cleanedWords.append(word)

    result = " ".join(cleanedWords)

    sentence1 = sentence.replace("-", " ")
    return result

