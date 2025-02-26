import string
import random
import time

class Robot:
    names = set()

    def __init__(self):
        self.random_name()

    def random_name(self):
        self.name = ""
        while self.name not in Robot.names:
            random.seed(time.time())
            self.name = "".join([random.choice(string.ascii_uppercase) for _ in range(2)] + [str(random.randint(0,9)) for _ in range(3)])
            Robot.names.add(self.name)

    def reset(self):
        Robot.names.remove(self.name)
        self.random_name()