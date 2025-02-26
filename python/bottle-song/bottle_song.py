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
    output = []
    for verse in range(take):
        temp = []
        temp.append(f"{num_botles[start - verse]} hanging on the wall,")
        temp.append(f"{num_botles[start - verse]} hanging on the wall,")
        temp.append(f"And if one green bottle should accidentally fall,")
        temp.append(f"There'll be {num_botles[start - verse - 1].lower()} hanging on the wall.")
        temp.append(f"")
        output.extend(temp)
    return output[:-1]