def commands(binary_str):
    binary_lst = [ True if bin == "1" else False for bin in binary_str ][::-1]
    actions = ["wink", "double blink", "close your eyes", "jump"]
    output = []
    for idx in range(len(actions)):
        if binary_lst[idx]:
            output.append(actions[idx])
    if binary_lst[-1]:
        output.reverse()
    return output