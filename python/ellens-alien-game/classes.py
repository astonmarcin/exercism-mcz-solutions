"""Solution to Ellen's Alien Game exercise."""


class Alien:
    """Create an Alien object with location x_coordinate and y_coordinate.

    Attributes
    ----------
    (class)total_aliens_created: int
    x_coordinate: int - Position on the x-axis.
    y_coordinate: int - Position on the y-axis.
    health: int - Number of health points.

    Methods
    -------
    hit(): Decrement Alien health by one point.
    is_alive(): Return a boolean for if Alien is alive (if health is > 0).
    teleport(new_x_coordinate, new_y_coordinate): Move Alien object to new coordinates.
    collision_detection(other): Implementation TBD.
    """

    total_aliens_created = 0

    def __init__(self, *coordinate):
        self.x_coordinate = coordinate[0]
        self.y_coordinate = coordinate[1]
        self.health = 3
        Alien.total_aliens_created += 1

    def hit(self):
        if self.health != 0:
            self.health -= 1

    def is_alive(self):
        if self.health != 0:
            return True
        return False

    def teleport(self, new_x_coordinate, new_y_coordinate):
        self.x_coordinate = new_x_coordinate
        self.y_coordinate = new_y_coordinate

    def collision_detection(self, second_alien):
        pass

def new_aliens_collection(aliens):
    return [Alien(*alien) for alien in aliens]
