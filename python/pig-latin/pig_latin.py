def translate(text):
    vowels = ("a","e","i","o","u")
    rule_1 = ("xr", "yt")
    output = []
    for word in text.split(" "):
        rule_number = 0
        break_char = 0
        if word.startswith(vowels) or word.startswith(rule_1):
            rule_number = 1
        else:
            for i, _ in enumerate(word):
                if i == len(word)-1:
                    break
                if word[i] == "q" and word[i+1] == "u":
                    rule_number = 3
                    break_char = i + 2
                    break
                if word[i] != "y" and word[i+1] == "y":
                    rule_number = 4
                    break_char = i + 1
                    break
                if word[i] in vowels:
                    rule_number = 2
                    break_char = i
                    break
    
        if rule_number == 0:
            output.append(word)
        elif rule_number == 1:
            output.append(word + "ay")
        else:
            output.append(word[break_char:] + word[:break_char] + "ay")
    
    return ' '.join(output)


