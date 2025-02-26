num_botles = {
    10: "Ten green bottles",
    9: "Nine green bottles",
    8: "Eight green bottles",
    7: "Seven green bottles",
    6: "Six green bottles",
    5: "Five green bottles",
    4: "Four green bottles",
    3: "Three green bottles",
    2: "Two green bottles",
    1: "One green bottle",
    0: "No green bottles",
}


def recite(start, take=1):
    def give_line(line_number, verse):
        return [
            f"{num_botles[start - verse]} hanging on the wall,",
            f"{num_botles[start - verse]} hanging on the wall,",
            f"And if one green bottle should accidentally fall,",
            f"There'll be {num_botles[start - verse - 1].lower()} hanging on the wall.",
            f"",
        ][line_number]

    return [give_line(line_number, verse) for verse in range(take) for line_number in range(0, 5)][:-1]
