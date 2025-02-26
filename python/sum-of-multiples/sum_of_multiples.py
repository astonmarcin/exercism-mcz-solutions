def sum_of_multiples(limit, multiples):
    ## one liner solution 🤯 replaces all code below
    #return sum({item for multiple in multiples if multiple != 0 for item in range(multiple, limit, multiple)})

    multipliers = set()
    for item in multiples:
        if item == 0:
            continue
        for multiplier in range(item, limit, item):
            multipliers.add(multiplier)
    return sum(multipliers)

