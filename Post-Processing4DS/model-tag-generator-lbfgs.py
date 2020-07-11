#-------------------------------------------------------------------------------
# Name:        Postagging for kabyle
# Purpose:     POS TAG for Kabyle to reconstruct sentences for STT purpose
#
# Author:      Muḥend Belqasem
#
# Created:     15/06/2020
# Copyright:   (c) Belkacem Mohammed 2020
# Licence:     <CC0>


from sklearn_crfsuite import CRF
from joblib import dump

def untag(tagged_sentence):
    """
    Given a tagged sentence, return an untagged version of that
    sentence.  I.e., return a list containing the first element
    of each tuple in *tagged_sentence*.
        >>> untag([('Muḥend', 'NNP'), ('yeswa', 'VP'), ('d', 'SFX')])
        ['Muḥend', 'yeswa', 'd']

    """
    return [w for (w, t) in tagged_sentence]


tagged_sentences=[]
#Construction du texte global à aprtir du corpus étiqueté
# corpus-kab-prenew2.txt contains sentences tagged manulally
first=0
taille2=0
for ligne in open("tagged-corpus.txt",encoding='utf-8'):
    taille=0
    if (first!=0):
        sentence=[]
        line=ligne.split()
        taille=len(line)
        for i in line:
            j=i.split('/')
            try:
             couple=(j[0],j[1])
            except:
                print(ligne)
                exit()
            sentence.append(couple)
        taille2=taille+taille2
        tagged_sentences.append(sentence)
    first=1

#Define word featrures of a Kabyle word

def features(sentence, index):
    return {
        'word': sentence[index],    # Awal s timmad-is/ The word itself
        'is_first': index == 0,     # Ma yezga-d deg tazwara n tefyirt / if it's the first word in the sentence
        'is_last': index == len(sentence) - 1, # Ma yezgma-d deg taggara n tefyirt, if the word is in  the end of the sentence
        'is_capitalized': sentence[index][0].upper() == sentence[index][0], # MA ibeddu s usekkil meqqren # if the word begins with a Capital letter
        'is_all_caps': sentence[index].upper() == sentence[index], # Ma yura meṛṛa s usekkil meqqren/ If the word is entierly Capitalized
        'is_all_lower': sentence[index].lower() == sentence[index], # ma yura meṛṛa s usekkil meẓẓiyen /If the word is entierly not Capitalized
        'prefix-1': sentence[index][0], #1 usekkil uzwir /first letter
        'prefix-2': sentence[index][:2], #2 isekkilen uzwiren /2 first letters
        'prefix-3': sentence[index][:3], #3 isekkilen uzwiren /3 first letters
        'prefix-4': sentence[index][:4], # 4 isekkilen uzwiren/4 first letters
        'prefix-5': sentence[index][:5], # 5 isekkilen uzwiren tettecmumuḥenḍ (aoriste intensif) /5 first letters
        'suffix-1': sentence[index][-1], #1 usekkil uḍfir /1 last letter
        'suffix-2': sentence[index][-2:], #2 isekkilen uḍfiren /2 last letters
        'suffix-3': sentence[index][-3:], #3 isekkilen uḍfiren /3 last letters
        'suffix-4': sentence[index][-4:], #4 isekkilen uḍfiren /4 last letter
        'prev_word': '' if index == 0 else sentence[index - 1], #awal uzwir / the word before
        'next_word': '' if index == len(sentence) - 1 else sentence[index + 1], #awal uḍfir / the word after

        'is_numeric': sentence[index].isdigit(),  #ma yegber kan izwilen / If it contains a digit
        'capitals_inside': sentence[index][1:].lower() != sentence[index][1:] #ma yegber asekkil meqqren daxel-is/ if it has a capital lette in the middle

        }

#transformation of the corpus x: contains tokens and tags, y contains tags
def transform_to_dataset(tagged_sentences):
    X, y = [], []

    for tagged in tagged_sentences:
        try:
         X.append([features(untag(tagged), index) for index in range(len(tagged))])
         y.append([tag for _, tag in tagged])
        except:
            print('erro',tagged)
            exit()


    return X, y
total=int(len(tagged_sentences)*0.80)

x,y=transform_to_dataset(tagged_sentences)
# train corpora
X1_train, y1_train = transform_to_dataset(tagged_sentences[:total])

#test corpora
X_test, y_test = transform_to_dataset(tagged_sentences[total:])
#model based on lbfgs algorithm
model = CRF(
    algorithm='lbfgs', # Limited-memory  Broyden–Fletcher–Goldfarb–Shanno Algorithm.
                       #Used to pos tag words or other information provided by the model within the situation.


    max_iterations=100,
    all_possible_transitions=True
)
#training
model.fit(X1_train, y1_train)


# save the model
dump(model, 'modellbfgs.joblib')
print ("################ Model generated - > Sucess")
