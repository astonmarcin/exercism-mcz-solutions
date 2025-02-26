import json
import itertools
def rectangles(strings):
    ## get all corners, char == "+"
    corners = []
    for line_idx, line in enumerate(strings):
        for char_idx, char in enumerate(line):
            if char == "+":
                corners.append((line_idx, char_idx))
    
    possible_rectangles = []
    count = 0
    
    loops = 0
    ## let's iterate through all corners, pretend this is our first one
    for first_corner in corners:
        ## get corners that shares same row and column
        #same_row = [row for row in range(0, len(corners)) if row != first_corner and corners[first_corner][0] == corners[row][0]]
        #same_col = [col for col in range(0, len(corners)) if col != first_corner and corners[first_corner][1] == corners[col][1]]
        print("actual corner:", first_corner)
        same_row = [row for row in corners if row != first_corner and first_corner[0] == row[0]]
        same_col = [col for col in corners if col != first_corner and first_corner[1] == col[1]]
        print("  same_row =", same_row, " ; same_col=", same_col)
        
        ## if there is no other corners in our coordinates - this is not a rectangle
        if len(same_row) != 0 and len(same_col) != 0:
            ## iterate through every possible 2nd and 3rd corner
            for second_corner, third_corner in itertools.product(same_row, same_col):
                #try:  ## to find 4th corner
                #    #fourth_corner = corners.index((corners[third_corner][0], corners[second_corner][1]))
                #except:
                #    continue
                fourth_corner = (third_corner[0], second_corner[1])
                print("    first_corner:", first_corner, "\n    second_corner:", second_corner, "\n    third_corner:", third_corner, "\n   fourth_corner:", fourth_corner)
                if fourth_corner not in corners:
                    continue
                loops += 1
                
                ## we've possible rectangle, let's write it
                rectangle = {first_corner, second_corner, third_corner, fourth_corner}
                
                if rectangle not in possible_rectangles:
                    ## a new rectangle, we need to check sides, 
                    possible_rectangles.append(rectangle)
                    ## collect indexes of each sides
                    top_row_idx = corners[first_corner][0]
                    bottom_row_idx = corners[third_corner][0]
                    left_col_idx = corners[first_corner][1]
                    right_col_idx = corners[second_corner][1]
                    ## get charactes of all rectangle sides
                    top_side = strings[top_row_idx][left_col_idx+1:right_col_idx]
                    bottom_side = strings[bottom_row_idx][left_col_idx+1:right_col_idx]
                    left_side = [strings[idx][left_col_idx] for idx in range(top_row_idx+1, bottom_row_idx)]
                    right_side = [strings[idx][right_col_idx] for idx in range(top_row_idx+1, bottom_row_idx)]
                    ## check if sides are valid
                    is_horizontal = all(char in "-+" for char in top_side + bottom_side)
                    is_vertical = all(char in "|+" for char in left_side + right_side)
                    ## if so - count rectangle to output
                    if is_horizontal and is_vertical:
                        count += 1
        
    print("\nloops:",loops)
    return count