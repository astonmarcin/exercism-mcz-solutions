def egg_count(display_value):
    return len([char for char in bin(display_value) if char == "1"])
