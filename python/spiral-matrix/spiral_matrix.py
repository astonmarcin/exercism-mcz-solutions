def spiral_matrix(size):
    ## our output matrix, will be filled with numbers
    output = [ [ 0 for _ in range(size)] for _ in range(size) ]

    ## 2D list with row and columns allowed to move, will be decreased in loop when reach corner of matrix
    allowed_coords = [ list(range(0, size)) for _ in range(2) ] 

    ## initial condifions
    coord = [0, 0]      ## starting cell of matrix, [<row idx>, <col_idx>]
    direction = 0       ## 0 = rigth; 1 = down; 2 = left; 3 = up

    for i in range(1, size**2+1):
        ## fill cell with number
        output[coord[0]][coord[1]] = i

        ## set min and max column and row, for code readability
        min_row = min(allowed_coords[0])
        max_row = max(allowed_coords[0])
        min_col = min(allowed_coords[1])
        max_col = max(allowed_coords[1])

        ## if there is a corner - decrease allowed coords and change direction:
        ## - upper left
        if direction == 3 and coord == [min_row, min_col]:
            allowed_coords[1].remove(min_col)                ## remove minimal column idx
            direction = (direction + 1) % 4                  ## change direction
        ## - upper rigth
        elif direction == 0 and coord == [min_row, max_col]:
            allowed_coords[0].remove(min_row)                ## remove minimal row idx
            direction = (direction + 1) % 4                  ## change direction
        ## - bottom rigth
        elif direction == 1 and coord == [max_row, max_col]:
            allowed_coords[1].remove(max_col)                ## remove maximal column idx
            direction = (direction + 1) % 4                  ## change direction
        ## - bottom left
        elif direction == 2 and coord == [max_row, min_col]:
            allowed_coords[0].remove(max_row)                ## remove maximal row idx
            direction = (direction + 1) % 4                  ## change direction

        ## set next cell for next iteration, based on direction
        if direction == 0:
            coord[1] += 1
        if direction == 1:
            coord[0] += 1
        if direction == 2:
            coord[1] -= 1
        if direction == 3:
            coord[0] -= 1

    return output
