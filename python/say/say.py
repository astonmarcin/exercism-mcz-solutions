suffix_map = {
    0: "",
    1: "thousand",
    2: "million",
    3: "billion",
}
number_map = {
    0: "",
    1: "one",
    2: "two",
    3: "three",
    4: "four",
    5: "five",
    6: "six",
    7: "seven",
    8: "eight",
    9: "nine",
}
teens_map = {
    0: "ten",
    1: "eleven",
    2: "twelve",
    3: "thirteen",
    4: "fourteen",
    5: "fifteen",
    6: "sixteen",
    7: "seventeen",
    8: "eighteen",
    9: "nineteen",
}
tys_map = {
    0: "",
    1: "",
    2: "twenty",
    3: "thirty",
    4: "forty",
    5: "fifty",
    6: "sixty",
    7: "seventy",
    8: "eighty",
    9: "ninety",
}

def say(number):
    if number < 0 or number > 999_999_999_999:
        raise ValueError("input out of range")
    number_lst = []
    
    ## breaking into 3-digit list
    while number > 0:
        number, modulo = divmod(number,1000)
        number_lst.append(modulo)
    if len(number_lst) == 0:
        return "zero"
    
    output = []
    for number_idx in range(len(number_lst)-1, -1, -1):
        num, suf = number_lst[number_idx], suffix_map[number_idx]
        
        if num == 0:
            continue
        
        ## break into digits
        digits = []
        for i in range(2, -1, -1):
            n, num = divmod(num, 10**i)
            digits.append(n)
        
        ## hundreds
        if digits[0] > 0:
            output.append(number_map[digits[0]])
            output.append("hundred")
        
        ## twenty to ninety
        if digits[1] >= 2 and digits[1] <= 9:
            if digits[2] > 0:
                output.append(f"{tys_map[digits[1]]}-{number_map[digits[2]]}")
            if digits[2] == 0:
                output.append(f"{tys_map[digits[1]]}")

        ## teens
        if digits[1] == 1:
            output.append(f"{teens_map[digits[2]]}")

        ## ones
        if digits[1] == 0 and digits[2] > 0:
            output.append(f"{number_map[digits[2]]}")
        
        if suf != "":
            output.append(suf)

    return " ".join(output) 