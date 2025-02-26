def factors(value):
    output = []
    div = 2

    while value > 1:
        if value % div == 0:
            output.append(div)
            value = value // div
        else:
            div += 1

    return output
