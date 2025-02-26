def find(search_list, value):
    if not value in search_list:
        raise ValueError("value not in array")
    return search_list.index(value)
