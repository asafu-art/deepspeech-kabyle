import string
import collections

allowed = list(string.ascii_lowercase)
allowed.append("-")
allowed.append(" ")
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
    "γ": "ɣ",
    "ε": "ɛ",
    "ţťŧț": "t",
    "ùúûũūŭůűųȕȗüû": "u",
    "ŵ": "w",
    "ýÿŷ": "y",
    "źżžȥ": "z",
    "ß": "ss",
}

punctuation = [
    "'",
    '"',
    ".",
    "?",
    ",",
    "!",
    ";",
    "_",
    ":",
    "/",
    "(",
    ")",
    "{",
    "}",
    "[",
    "]",
]

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


def removePunctuation(word):
    for i in word:
        if i in punctuation or i not in allowed:
            word = word.replace(i, "")
    return word


def cleanWord(word):
    word = word.lower()
    word = remplaceSymbols(word)
    word = removePunctuation(word)
    return word


def checkSentence(sentence):
    for i in sentence:
        if i not in allowed:
            return False
        if sentence.find(" -") > 0 or sentence.find("- ") > 0:
            return False
    return True


def cleanSentence(sentence):

    sentence = sentence.strip()
    sentence = sentence.lower()
    sentence = remplaceSymbols(sentence)
    sentence = removePunctuation(sentence)

    a = checkSentence(sentence)

    words = sentence.strip().split(" ")
    # print(words)
    cleanedWords = []
    for word in words:
        word = cleanWord(word)
        # if word.__contains__("a"):
        #    print(word)
        cleanedWords.append(word)

    result = " ".join(cleanedWords)

    sentence1 = sentence.replace("-", " ")
    return result

