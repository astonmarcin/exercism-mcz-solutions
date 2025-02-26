resistor_colors = {
    "black": 0,
    "brown": 1,
    "red": 2,
    "orange": 3,
    "yellow": 4,
    "green": 5,
    "blue": 6,
    "violet": 7,
    "grey": 8,
    "white": 9
}

prefixes = {
    1000000000: "giga",
    1000000: "mega",
    1000: "kilo",
    1: "",
}

tolerances = {
    "grey": "0.05%",
    "violet": "0.1%",
    "blue": "0.25%",
    "green": "0.5%",
    "brown": "1%",
    "red": "2%",
    "gold": "5%",
    "silver": "10%",
}

def resistor_label(colors):
    if len(colors) == 1:
        return "0 ohms"
    if len(colors) == 4:
        resistor_value = (resistor_colors[colors[0]] * 10 + resistor_colors[colors[1]]) * 10 ** resistor_colors[colors[2]]
    if len(colors) == 5:
        resistor_value = (resistor_colors[colors[0]] * 100 + resistor_colors[colors[1]] * 10 + resistor_colors[colors[2]]) * 10 ** resistor_colors[colors[3]]
    else:
        ValueError("input colors has not valid lenght, valid is: 1, 4, 5")
    for multiplier, prefix in prefixes.items():
        if resistor_value >= multiplier:
            print(resistor_value, multiplier)
            return str(resistor_value / multiplier).rstrip('0').rstrip('.') + " " + prefix + "ohms ±" + tolerances[colors[-1]]
    return str(resistor_value) + " ohms ±" + tolerances[colors[-1]]
