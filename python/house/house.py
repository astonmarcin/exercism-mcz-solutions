nouns_and_verbs = [
    "house that Jack built.",
    ("malt", "lay in",),
    ("rat", "ate",),
    ("cat", "killed",),
    ("dog", "worried",),
    ("cow with the crumpled horn", "tossed",),
    ("maiden all forlorn", "milked",),
    ("man all tattered and torn", "kissed",),
    ("priest all shaven and shorn", "married",),
    ("rooster that crowed in the morn", "woke",),
    ("farmer sowing his corn", "kept",),
    ("horse and the hound and the horn", "belonged to",),
]

def recite(start_verse, end_verse):
    return [
        "This is the " + " the ".join(
            f"{nouns_and_verbs[verse][0]} that {nouns_and_verbs[verse][1]}" if verse != 0 else f"{nouns_and_verbs[0]}"
            for verse in range(no_verses, -1, -1)
        )
        for no_verses in range(start_verse-1, end_verse)
    ]
