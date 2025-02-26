from math import gcd

def triplets_with_sum(number):
    ## euclid formula:
    output = []
    print(int(number**0.5 + 1))
    for m in range(1, int(number**0.5+1)):
        for n in range(1, m):
            if gcd(m,n) == 1 and (m-n) % 2 == 1: 
                k = 1
                a, b, c = m**2 - n**2, 2*m*n, m**2 + n**2
                while k * c < number:
                    if k * (a + b + c) == number:
                        output.append(sorted([k*a,k*b,k*c]))
                    k += 1
    return output

    ## slower algo for very large numbers
    #
    #if number % 2 != 0:
    #    return []
    #output = []
    #for a in range(1, int(number/3)):
    #    for b in range(a+1, int(number/2)):
    #        c = number - a - b
    #        if a**2 + b**2 == c**2:
    #            output.append([a, b, c])
    #return output
