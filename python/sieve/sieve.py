def primes(limit):
    output = {number for number in range(2, limit+1)}
    for i in range(2, limit+1):
        if i not in output:
            continue
        for j in range(i*2, limit+1, i):
            output.discard(j)
    return list(output)
