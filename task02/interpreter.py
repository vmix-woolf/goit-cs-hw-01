from token_type import TokenType


class Interpreter:
    def __init__(self, parser):
        self.parser = parser

    def visit_BinOp(self, left, op, right):  # Modified to accept left, op, right
        if op.type == TokenType.PLUS:
            return left + right
        elif op.type == TokenType.MINUS:
            return left - right
        elif op.type == TokenType.MUL:
            return left * right
        elif op.type == TokenType.DIV:
            return left / right
        else:
            raise Exception(f"Unknown operator: {op.type}")

    def interpret(self):
        tree = self.parser.expr()
        return self.visit(tree)

    def visit(self, node):
        if isinstance(node, int) or isinstance(node, float):
            return node
        elif isinstance(node, tuple) and len(node) == 3:  # Check for BinOp tuple
            return self.visit_BinOp(node[0], node[1], node[2])
        else:
            raise Exception(f"Unknown node type: {type(node)}")