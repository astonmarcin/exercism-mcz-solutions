def saddle_points(matrix):
    ## error handing
    if not all(len(row) == len(matrix[0]) for row in matrix):
        raise ValueError("irregular matrix")

    ## calculation
    output = []
    for row_idx, row in enumerate(matrix):
        for col_idx, col in enumerate(row):
            column = [matrix[r][col_idx] for r in range(len(matrix))]
            if col == max(row) and col == min(column):
                output.append({"row": row_idx+1, "column": col_idx+1})
    return output

    ## oneliner solution:
    #return [
    #    {"row": row_idx+1, "column": col_idx+1} 
    #    for row_idx, row in enumerate(matrix) 
    #    for col_idx, col in enumerate(row) 
    #    if col == max(row) and col == min([matrix[r][col_idx] for r in range(len(matrix))])
    #]
