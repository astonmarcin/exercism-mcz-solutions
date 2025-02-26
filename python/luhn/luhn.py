class Luhn:
    input = ""

    def __init__(self, card_num):
        self.input = card_num.replace(" ", "")

    def valid(self):
        if not self.input.isdigit() or len(self.input) <= 1:
            return False

        if len(self.input) % 2 != 0:
            self.input = "0" + self.input

        output = 0
        for idx, val in enumerate(self.input):
            digit = int(val)
            if idx %2 == 0:
                digit *= 2
            if digit > 9:
                digit -= 9
            output += digit

        return output % 10 == 0