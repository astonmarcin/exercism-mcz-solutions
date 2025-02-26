def flatten(iterable):
    output = []
    def helper(lst):
        for elem in lst:
            if type(elem) == list:
                helper(elem)
            else:
                if elem not in [None, ""]:
                    output.append(elem)
    helper(iterable)
    return output
