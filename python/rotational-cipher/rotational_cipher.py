from string import ascii_uppercase,ascii_lowercase

def rotate(text, key):
    translate = str.maketrans(ascii_uppercase + ascii_lowercase, ascii_uppercase[key:] + ascii_uppercase[:key] + ascii_lowercase[key:] + ascii_lowercase[:key])
    return text.translate(translate)
