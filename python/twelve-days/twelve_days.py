days = {
    1: "first",
    2: "second",
    3: "third",
    4: "fourth",
    5: "fifth",
    6: "sixth",
    7: "seventh",
    8: "eighth",
    9: "ninth",
    10: "tenth",
    11: "eleventh",
    12: "twelfth",
}
presents = [
    "a Partridge in a Pear Tree.",
    "two Turtle Doves, ",
    "three French Hens, ",
    "four Calling Birds, ",
    "five Gold Rings, ",
    "six Geese-a-Laying, ",
    "seven Swans-a-Swimming, ",
    "eight Maids-a-Milking, ",
    "nine Ladies Dancing, ",
    "ten Lords-a-Leaping, ",
    "eleven Pipers Piping, ",
    "twelve Drummers Drumming, ",
]

def recite(start_verse, end_verse):
    return [
        "".join(
            [f"On the {days[day]} day of Christmas my true love gave to me: "] + presents[:day][::-1]
            if day == 1 else 
            [f"On the {days[day]} day of Christmas my true love gave to me: "] + presents[1:day][::-1] + [f"and {presents[0]}"]
        )
        for day in range(start_verse, end_verse + 1)
    ]