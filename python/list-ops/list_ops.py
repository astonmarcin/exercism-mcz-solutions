def append(list1, list2):
    return list1 + list2


def concat(lists):
    return [inner for outer in lists for inner in outer]


def filter(function, list):
    return [elem for elem in list if function(elem)]


def length(list):
    return len(list)


def map(function, list):
    return [function(elem) for elem in list]


def foldl(function, list, initial):
    for elem in list:
        initial = function(initial, elem)
    return initial


def foldr(function, list, initial):
    return foldl(function, list[::-1], initial)


def reverse(list):
    return list[::-1]
