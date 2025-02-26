def is_armstrong_number(number):
    digits = [int(digit) for digit in str(number)]
    length = len(digits)
    output = 0
    for i in range(length):
        output += digits[i] ** (length)
    return output == number
