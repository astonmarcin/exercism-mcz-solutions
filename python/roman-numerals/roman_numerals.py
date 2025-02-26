convert_matrix = [
    ["M", 1000],
    ["CM", 900],
    ["D", 500],
    ["CD", 400],
    ["C", 100],
    ["XC", 90],
    ["L", 50],
    ["XL", 40],
    ["X", 10],
    ["IX", 9],
    ["V", 5],
    ["IV", 4],
    ["I", 1],
]

def roman(number):
    ## oneliner 🤯
    return "".join(roman_number * (number // arab_number) + (number := number % arab_number) * "" for roman_number, arab_number in convert_matrix)
    
    #multipliers = []
    #for roman_number, arab_number in convert_matrix:
    #    multipliers.append(roman_number * (number // arab_number))
    #    number = number % arab_number
    #return "".join(multipliers)
