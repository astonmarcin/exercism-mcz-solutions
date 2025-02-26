from string import ascii_lowercase

def is_isogram(string):
    return all(string.lower().count(letter) <= 1 for letter in ascii_lowercase)
