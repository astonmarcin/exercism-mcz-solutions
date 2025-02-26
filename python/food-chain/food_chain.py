animals = [
    "fly",
    "spider",
    "bird",
    "cat",
    "dog",
    "goat",
    "cow",
    "horse",
]

animals_params = {
    "fly": {
        "second_line": "I don't know why she swallowed the fly. Perhaps she'll die.",
    },
    "spider": {
        "second_line": "It wriggled and jiggled and tickled inside her.",
        "middle_line_modifier": "that wriggled and jiggled and tickled inside her",
    },
    "bird": {
        "second_line": "How absurd to swallow a bird!",
    },
    "cat": {
        "second_line": "Imagine that, to swallow a cat!",
    },
    "dog": {
        "second_line": "What a hog, to swallow a dog!",
    },
    "goat": {
        "second_line": "Just opened her throat and swallowed a goat!",
    },
    "cow": {
        "second_line": "I don't know how she swallowed a cow!",
    },
    "horse": {
        "second_line": "She's dead, of course!",
        "end": True,
    },
}

def recite(start_verse: int, end_verse: int):
    output = []
    for version in range(start_verse-1, end_verse):
        animal = animals[version]
        output.append(f"I know an old lady who swallowed a {animal}.")
        output.append(animals_params[animal]["second_line"])
        if not animals_params[animal].get("end", False):
            for verse in range(version, 0, -1):
                second_animal = animals[verse-1] if not animals_params[animals[verse-1]].get("middle_line_modifier", False) else f'{animals[verse-1]} {animals_params[animals[verse-1]]["middle_line_modifier"]}'
                output.append(f"She swallowed the {animals[verse]} to catch the {second_animal}.")
                if verse == 1:
                    output.append(animals_params[animals[0]]["second_line"])
        output.append("")
    return output[:-1]