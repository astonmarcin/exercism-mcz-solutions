# Possible sublist categories.
SUBLIST = 1
SUPERLIST = 2
EQUAL = 3
UNEQUAL = 4


def is_contained(lst_big, lst_small):
    """
    Checks if shorter list `lst_small` is within longer one `lst_big` in the same order

    :param lst_big: list - a longer list of elements
    :param lst_small: list a shorter list of elements
    :return: bool - True if lst_small is within lst_big in the same order, False if not
    """
    for i in range(len(lst_big) - len(lst_small) + 1):
        if lst_big[i:i + len(lst_small)] == lst_small:
            return True
    return False

def sublist(list_one, list_two):
    if not type(list_one) is list or not type(list_two) is list:
        return
    if list_one == list_two:
        return EQUAL
    elif len(list_one) > len(list_two) and is_contained(list_one, list_two):
        return SUPERLIST
    elif len(list_one) < len(list_two) and is_contained(list_two, list_one):
        return SUBLIST
    return UNEQUAL
