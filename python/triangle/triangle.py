def is_triangle(sides):
    side_0 = sides[0] + sides[1] > sides[2]
    side_1 = sides[1] + sides[2] > sides[0]
    side_2 = sides[2] + sides[0] > sides[1]
    return any(elem != 0 for elem in sides) and side_0 and side_1 and side_2

def equilateral(sides):
    return is_triangle(sides) and any(sides.count(elem) == 3 for elem in sides)

def isosceles(sides):
    return is_triangle(sides) and any(sides.count(elem) >= 2 for elem in sides)

def scalene(sides):
    return is_triangle(sides) and not any(sides.count(elem) > 1 for elem in sides)
