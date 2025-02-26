def score(x, y):
    diag = (x**2 + y**2) ** 0.5
    if diag <= 1:
        return 10
    if diag <= 5:
        return 5
    if diag <= 10:
        return 1
    return 0
    
