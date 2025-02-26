import random

class Character:
    def __init__(self):
        self.strength = self.ability()
        self.dexterity = self.ability()
        self.constitution = self.ability()
        self.intelligence = self.ability()
        self.wisdom = self.ability()
        self.charisma = self.ability()
        self.hitpoints = 10 + modifier(self.constitution)
    
    @staticmethod
    def ability():
        return sum(sorted([random.randint(1, 6) for _ in range(6)])[3:])

def modifier(value):
    return (value - 10) // 2