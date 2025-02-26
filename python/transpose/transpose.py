from itertools import zip_longest

def transpose(text):
    placeholder = '\uFFFF'
    lines = text.split("\n")

    output = []
    for transponed_line in zip_longest(*lines, fillvalue=placeholder):
        output.append("".join(transponed_line).rstrip(placeholder).replace(placeholder, " "))
    return "\n".join(output)