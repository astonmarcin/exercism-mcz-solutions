# Globals for the directions
# Change the values as you see fit
EAST = 1
NORTH = 0
WEST = 3
SOUTH = 2


class Robot:
    def __init__(self, direction=NORTH, x_pos=0, y_pos=0):
        self.direction = direction
        self.coordinates = (x_pos, y_pos)

    def move(self, move):
        for char in move:
            if char == "R":
                self.direction = (self.direction + 1) % 4
            if char == "L":
                self.direction = (self.direction - 1) % 4
            if char == "A":
                if self.direction == NORTH:
                    self.coordinates = (self.coordinates[0], self.coordinates[1] + 1)
                if self.direction == EAST:
                    self.coordinates = (self.coordinates[0] + 1, self.coordinates[1])
                if self.direction == SOUTH:
                    self.coordinates = (self.coordinates[0], self.coordinates[1] - 1)
                if self.direction == WEST:
                    self.coordinates = (self.coordinates[0] - 1, self.coordinates[1])
    
