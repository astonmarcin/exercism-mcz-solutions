def decode(number):
    decode_matrix = {
        " _ | ||_|   ": 0,
        "     |  |   ": 1,
        " _  _||_    ": 2,
        " _  _| _|   ": 3,
        "   |_|  |   ": 4,
        " _ |_  _|   ": 5,
        " _ |_ |_|   ": 6,
        " _   |  |   ": 7,
        " _ |_||_|   ": 8,
        " _ |_| _|   ": 9,
    }
    if  not number in decode_matrix.keys():
        return "?"
    return str(decode_matrix[number])

def convert(input_grid: list):
    input_grid_length = len(input_grid)
    line_length = len(input_grid[0])
    if len(input_grid) % 4 != 0:
        raise ValueError("Number of input lines is not a multiple of four")
    for line in input_grid:
        if len(line) % 3 != 0 or len(line) != line_length:
            raise ValueError("Number of input columns is not a multiple of three")
    
    numbers = [ 
        [
            "".join(input_grid[4*row+i][3*col+j] 
            for i in range(4) 
            for j in range(3)) 
            for col in range(line_length // 3)
        ] 
        for row in range(input_grid_length // 4) 
    ]
    return ",".join(["".join(decode(number) for number in inner_list) for inner_list in numbers])