def slices(series, length):
    series_len = len(series)

    if length == 0:
        raise ValueError("slice length cannot be zero")
    if length < 0:
        raise ValueError("slice length cannot be negative")
    if series_len == 0:
        raise ValueError("series cannot be empty")
    if length > series_len:
        raise ValueError("slice length cannot be greater than series length")

    return [ "".join(series[i+j] for j in range(0, length)) for i in range(0, series_len - length + 1) ]


