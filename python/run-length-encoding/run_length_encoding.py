def decode(string):
    idx = 0
    output = ""
    while idx < len(string):
        count = ""
        while string[idx].isdigit():
            count += string[idx]
            idx += 1
        letter = string[idx]
        for _ in range(0, int(count if count != "" else 1)):
            output += letter
        idx += 1
    return output


def encode(string):
    idx = 0
    output = ""
    while idx < len(string):
        count = 1
        letter = string[idx]
        while idx + 1 < len(string) and string[idx + 1] == letter:
            idx += 1
            count += 1
        output += f"{letter}" if count == 1 else f"{count}{letter}"
        idx += 1
    return output

