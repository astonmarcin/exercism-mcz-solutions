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

def label(colors):
    resistor_value = (resistor_colors[colors[0]] * 10 + resistor_colors[colors[1]]) * 10 ** resistor_colors[colors[2]]
    for multiplier, prefix in prefixes.items():
        if resistor_value >= multiplier:
            return str(int(resistor_value / multiplier)) + " " + prefix + "ohms"
    return str(resistor_value) + " ohms"
    