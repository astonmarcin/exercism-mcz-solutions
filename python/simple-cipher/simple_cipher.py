from string import ascii_lowercase
import random


class Cipher:
    def __init__(self, key=None):
        if not key:
            self.key = ''.join(random.choices(ascii_lowercase, k=100))
        else:
            self.key = key

    def ciphering(self, text, _enc):
        output = ""
        for idx, char in enumerate(text):
            key_char = self.key[idx % len(self.key)]
            old_ascii_index = ascii_lowercase.index(char)
            operation = (lambda x, y: x + y) if _enc else (lambda x, y: x - y)
            new_ascii_index = operation(old_ascii_index, ascii_lowercase.index(key_char)) % len(ascii_lowercase)
            output += ascii_lowercase[new_ascii_index]
        return output
    
    def encode(self, text):
        return self.ciphering(text, True)

    def decode(self, text):
        return self.ciphering(text, False)