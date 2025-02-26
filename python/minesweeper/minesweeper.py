def annotate(minefield):
    ## field types
    empty, mine = " ", "*"

    ## error handling
    if any(len(row) != len(minefield[0]) for row in minefield) or  any(char not in [empty, mine] for row in minefield for char in row):
        raise ValueError("The board is invalid with current input.")
    if not minefield:
        return []

    ## iterate through every field in minefield
    for row_idx, row in enumerate(minefield):
        for col_idx, cell in enumerate(row):
            if cell == empty:
                ## get number of mines in neighbour
                mines_cnt = sum(
                    minefield[r][c] == mine 
                    for c in [col_idx-1, col_idx, col_idx+1]
                    for r in [row_idx-1, row_idx, row_idx+1]
                    if 0 <= r < len(minefield) and 0 <= c < len(row)
                    )
                if mines_cnt > 0:
                    minefield[row_idx] = minefield[row_idx][:col_idx] + str(mines_cnt) + minefield[row_idx][col_idx+1:]
    return minefield
