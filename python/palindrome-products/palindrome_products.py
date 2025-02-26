def largest(min_factor, max_factor):
    """Given a range of numbers, find the largest palindromes which
       are products of two numbers within that range.

    :param min_factor: int with a default value of 0
    :param max_factor: int
    :return: tuple of (palindrome, iterable).
             Iterable should contain both factors of the palindrome in an arbitrary order.
    """

    if min_factor > max_factor:
        raise ValueError("min must be <= max")

    output = (0, [])
    for a in range(max_factor, min_factor - 1, -1):
        for b in range(a, min_factor - 1, -1):
            product = a * b
            if product <= output[0]:
                break
            if str(product) == str(product)[::-1]:
                output = (product, [[a,b]])
    
    if output[0] == 0:
        output = (None, output[1])

    print(output)
    return output


def smallest(min_factor, max_factor):
    """Given a range of numbers, find the smallest palindromes which
    are products of two numbers within that range.

    :param min_factor: int with a default value of 0
    :param max_factor: int
    :return: tuple of (palindrome, iterable).
    Iterable should contain both factors of the palindrome in an arbitrary order.
    """

    if min_factor > max_factor:
        raise ValueError("min must be <= max")

    output = (0, [])
    for a in range(min_factor, max_factor - 1):
        for b in range(a, max_factor - 1):
            product = a * b
            if product <= output[0]:
                break
            if str(product) == str(product)[::-1]:
                output = (product, [[a,b]])

    if output[0] == 0:
        output = (None, output[1])

    print(output)
    return output