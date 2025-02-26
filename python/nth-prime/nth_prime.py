def get_primes(limit):
    output = {number for number in range(2, limit+1)}
    for i in range(2, limit+1):
        if i not in output:
            continue
        for j in range(i*2, limit+1, i):
            output.discard(j)
    return list(output)


def prime(number):
    if number < 1:
        raise ValueError('there is no zeroth prime')

    total = 0
    factor = 2
    primes = []

    while total < number:
        primes = get_primes(number * factor)
        total = len(primes)
        factor += 1
    
    return primes[number-1]
        

