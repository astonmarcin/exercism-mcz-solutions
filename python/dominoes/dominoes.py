from itertools import permutations

def can_chain(dominoes):
    if len(dominoes) == 0:
        return []

    ## more optimal solution - cover all possible set of dominoes, not simply iterate with reversed list ;) 
    for permutation in permutations(dominoes):

        taken = [permutation[0]]
        remaining = [*permutation[1:]]
    
        for _ in range(len(dominoes) - 1):
            for remain in remaining:
                if remain[0] == taken[-1][1]:
                    taken.append(remain)
                    remaining.remove(remain)
                    break
                elif remain[1] == taken[-1][1]:
                    taken.append(remain[::-1])
                    remaining.remove(remain)
                    break

        if len(remaining) == 0 and taken[0][0] == taken[-1][1]:
            return taken
    return  (None)
