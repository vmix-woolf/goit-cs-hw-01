class Token:
    def __init__(self, ttype, value):
        self.type = ttype
        self.value = value

    def __str__(self):
        return f'Token({self.type}, {self.value})'