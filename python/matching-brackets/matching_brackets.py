def is_paired(input_string):
    openings = ['(', '[', '{']
    closings = [')', ']', '}']
    opened = []
    for char in input_string:
        if char in openings:
            opened.append(openings.index(char))
        if char in closings:
            if opened and opened[-1] == closings.index(char):
                opened.pop()
            else:
                return False

    return not opened