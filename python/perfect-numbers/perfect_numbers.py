def classify(number):
    """ A perfect number equals the sum of its positive divisors.

    :param number: int a positive integer
    :return: str the classification of the input integer
    """

    if number < 1:
        raise ValueError("Classification is only possible for positive integers.")

    output = 0
    for i in range(1, number):
        if number % i == 0:
            output += i

    if output > number:
        return "abundant"
    if output < number:
        return "deficient"
    return "perfect"
