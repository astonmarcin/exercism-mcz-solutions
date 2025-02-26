def proverb(*input, **kwargs):
    if len(input) > 0:
        last = f"{kwargs['qualifier']} {input[0]}" if kwargs["qualifier"] != None else input[0]
        return [f"For want of a {input[idx]} the {input[idx+1]} was lost." for idx, _ in enumerate(input[:-1])] + [f"And all for the want of a {last}."]
    return []