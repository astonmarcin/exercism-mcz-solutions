class SpaceAge:
    ## 365,25 days to seconds
    SECONDS_IN_YEAR = 365.25 * 24 * 60 * 60


    def __init__(self, seconds):
        self.seconds = seconds
        self.years = seconds / self.SECONDS_IN_YEAR

    def on_earth(self):
        orbital_period = 1.0
        return round(self.years / orbital_period, 2)

    def on_mercury(self):
        orbital_period = 0.2408467
        return round(self.years / orbital_period, 2)

    def on_venus(self):
        orbital_period = 0.61519726
        return round(self.years / orbital_period, 2)

    def on_mars(self):
        orbital_period = 1.8808158
        return round(self.years / orbital_period, 2)

    def on_jupiter(self):
        orbital_period = 11.862615
        return round(self.years / orbital_period, 2)

    def on_saturn(self):
        orbital_period = 29.447498
        return round(self.years / orbital_period, 2)

    def on_uranus(self):
        orbital_period = 84.016846
        return round(self.years / orbital_period, 2)

    def on_neptune(self):
        orbital_period = 164.79132
        return round(self.years / orbital_period, 2)