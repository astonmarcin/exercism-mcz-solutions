def is_valid(isbn):
    isbn = isbn.replace('-', '')
    if len(isbn) != 10:
        return False
    try:
        digits = [int(digit) for digit in isbn[0:9]]
        digits.append(int(isbn[9]) if isbn[9] !='X' else 10)
    except ValueError as e:
        print("Error in converting str to int: " + str(e))
        return False
    total = 0
    for i, _ in enumerate(digits):
        total += (i+1) * digits[-i-1]
    return total % 11 == 0
    