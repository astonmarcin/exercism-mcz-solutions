from string import ascii_uppercase

def rows(letter):
    ## calculate size of output
    output_size = (ascii_uppercase.index(letter) + 1) * 2 - 1
    ## calculate middle point
    output_middle = int((output_size + 1) / 2)

    output = []
    letter_idx = 0
    for output_idx in range(0, output_size):
        temp_list = list(' ' * output_size)
        temp_list[output_middle-letter_idx-1] = ascii_uppercase[letter_idx]
        temp_list[output_middle+letter_idx-1] = ascii_uppercase[letter_idx]
        output.append(''.join(temp_list))

        if output_idx >= ascii_uppercase.index(letter):
            letter_idx -= 1
        else:
            letter_idx += 1

    return output

