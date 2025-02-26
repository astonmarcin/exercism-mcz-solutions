def encode(numbers):
    ## convert numbers to binary string
    numbers_str = [bin(number)[2:].rjust(((len(bin(number)[2:]) + 6) // 7) * 7, "0") for number in numbers]
    
    ## encode to VLQ
    output = []
    for number in numbers_str:
        number_splitted = [number[0+i:7+i] for i in range(0, len(number), 7)]
        output.extend(int("1" + number, 2) for number in number_splitted[:-1])
        output.append(int("0" + number_splitted[-1], 2))
    return output


def decode(bytes_):
    ## convert to strings
    bytes_str = [bin(byte)[2:].rjust(8,"0") for byte in bytes_]
    
    ## error handling
    if bytes_str[-1][0] == "1":
        raise ValueError("incomplete sequence")
    
    ## merge bytes to numbers
    bytes_merged = [""]
    for byte in bytes_str:
        bytes_merged[-1] += byte[1:]
        if byte.startswith("0"):
            bytes_merged.append("")

    ## return numbers in as numbers (convert from strings)
    return [int(number, 2) for number in bytes_merged[:-1]]
