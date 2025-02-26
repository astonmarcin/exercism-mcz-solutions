from string import punctuation

def count_words(sentence: str):
    punctuation_ = punctuation.replace("'","")
    str_translate = str.maketrans(punctuation_, ' ' * len(punctuation_))

    words = [word.lstrip("'").rstrip("'").lower() for word in sentence.translate(str_translate).strip("'").split()]

    return {word: words.count(word) for word in words}


    ## human readable ;)
    
    ## words separation:
    #words = []
    #for word in sentence.translate(str_translate).strip("'").split():
    #    words.append(word.lstrip("'").rstrip("'").lower())

    ## output, counting words and put the to dict
    #output = {}
    #for word in words:
    #    output[word] = output.get(word, 0) + 1
    #return output