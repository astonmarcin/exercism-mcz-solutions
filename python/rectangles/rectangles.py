from itertools import product


def rectangles(strings):
    ## get all corners, char == "+"
    corners = []
    for line_idx, line in enumerate(strings):
        for char_idx, char in enumerate(line):
            if char == "+":
                corners.append((line_idx, char_idx))
    
    visited_rectangles = []
    visited_corners = []
    count = 0
    
    ## let's iterate through all corners, pretend this is our first one
    for first_corner in corners:
        visited_corners.append(first_corner)
        
        ## take all corners with the same row and col as the first
        second_corners, third_corners = [], []
        for corner in corners:
            if corner not in visited_corners:
                if first_corner[0] == corner[0]:
                    second_corners.append(corner)
                if first_corner[1] == corner[1]:
                    third_corners.append(corner)

        ## iterate through possible second and third corner
        for second_corner, third_corner in product(second_corners, third_corners):
            ## based on third and second corner - check if the fourth is valid
            fourth_corner = (third_corner[0], second_corner[1])
            if fourth_corner not in corners:
                continue

            ## collect indexes of each sides
            top_row_idx = first_corner[0]
            bottom_row_idx = third_corner[0]
            left_col_idx = first_corner[1]
            right_col_idx = second_corner[1]

            if (
                (top_row_idx < bottom_row_idx) and 
                (left_col_idx < right_col_idx) and 
                (first_corner[0] == second_corner[0]) and 
                (second_corner[1] == fourth_corner[1]) and 
                (fourth_corner[0] == third_corner[0]) and 
                (third_corner[1] == first_corner[1])
                ):
                ## we've got the possible rectangle, let's write it
                rectangle = {first_corner, second_corner, third_corner, fourth_corner} 

                if rectangle not in visited_rectangles:
                    ## a new rectangle, we need to check sides, 
                    visited_rectangles.append(rectangle)

                    ## check if top side valid
                    if not all(char in "-+" for char in strings[top_row_idx][left_col_idx+1:right_col_idx]):
                        continue
                    ## check if bottom side valid
                    if not all(char in "-+" for char in strings[bottom_row_idx][left_col_idx+1:right_col_idx]):
                        continue
                    ## check if left side valid
                    if not all(char in "|+" for char in [strings[idx][left_col_idx] for idx in range(top_row_idx+1, bottom_row_idx)]):
                        continue
                    ## check if right side valid
                    if not all(char in "|+" for char in [strings[idx][right_col_idx] for idx in range(top_row_idx+1, bottom_row_idx)]):
                        continue

                    count += 1
        
    return count
