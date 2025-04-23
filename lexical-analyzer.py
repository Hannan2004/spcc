import re

# Token specifications
TOKEN_SPECIFICATION = [
    ('NUMBER',   r'\d+(\.\d+)?'),              # Integer or decimal number
    ('ID',       r'[A-Za-z_]\w*'),             # Identifiers
    ('OP',       r'==|!=|<=|>=|[+\-*/%=<>]'),    # Operators
    ('STRING',   r'"[^"\n]*"'),                # String literals
    ('CHAR',     r"'[^']'"),                   # Character literals
    ('SYMBOL',   r'[{}()\[\];,]'),             # Symbols
    ('NEWLINE',  r'\n'),                       # Line endings
    ('SKIP',     r'[ \t]+'),                   # Skip spaces and tabs      # Single and multi-line comments
    ('MISMATCH', r'.'),                        # Any other character
]

KEYWORDS = {
    'int', 'float', 'char', 'double', 'if', 'else', 'for', 'while', 'do', 'return',
    'break', 'continue', 'void', 'struct', 'typedef', 'include', 'define', 'const'
}

token_regex = '|'.join(f'(?P<{name}>{pattern})' for name, pattern in TOKEN_SPECIFICATION)
get_token = re.compile(token_regex).match
def lexer(code):
    line_num = 1
    pos = 0
    token = []

    while pos < len(code):
      match = get_token(code,pos)
      if not match:
        raise SyntaxError(f'Illegal character at {line_num}')
      kind = match.lastgroup
      value = match.group()

      if kind == 'NEWLINE':
         line_num += 1
      elif kind == 'SKIP':
         pass
      elif kind == 'MISMATCH':
         raise SyntaxError(f'Unexpected character at {line_num}')
      else:
        if kind == 'ID' and value in KEYWORDS:
            kind = 'KEYWORD'
        token.append((kind,value))
      pos = match.end()
    return token
 
def analyze():
    with open('sample.c', 'r') as file:
        code = file.read()
        token_list = lexer(code)

        print("TOKEN LIST:")
        for token in token_list:
            print(token)
        print(f"\nTotal tokens: {len(token_list)}")

if __name__ == "__main__":
    analyze()