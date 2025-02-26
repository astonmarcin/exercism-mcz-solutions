from string import ascii_lowercase,punctuation

cipher = str.maketrans(ascii_lowercase, ascii_lowercase[::-1])
rid_out_puctuation = str.maketrans("", "", punctuation)

def encode(plain_text):
    output = plain_text.translate(rid_out_puctuation).replace(' ', '').lower().translate(cipher)
    return ' '.join([ output[idx:idx+5] for idx in range(0, len(output), 5) ])

def decode(ciphered_text):
    return ciphered_text.replace(" ", "").translate(cipher)
