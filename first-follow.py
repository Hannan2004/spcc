from collections import defaultdict

# Input grammar
grammar = {
    'S': ['AB'],
    'A': ['a', 'ε'],
    'B': ['b']
}

first = defaultdict(set)
follow = defaultdict(set)

def compute_first(X):
    if X.islower() or X == 'ε':  # terminal or epsilon
        return {X}
    
    if X in first and first[X]:
        return first[X]
    
    for production in grammar[X]:
        for i, symbol in enumerate(production):
            sym_first = compute_first(symbol)
            first[X].update(sym_first - {'ε'})
            
            if 'ε' not in sym_first:
                break
        else:
            first[X].add('ε')
    
    return first[X]

def compute_follow(X):
    if not follow[X]:  # only compute if not already done
        if X == start_symbol:
            follow[X].add('$')  # $ = end of input
        
        for lhs in grammar:
            for production in grammar[lhs]:
                for i in range(len(production)):
                    if production[i] == X:
                        after = production[i+1:]
                        if after:
                            first_of_next = set()
                            for symbol in after:
                                first_of_next |= compute_first(symbol) - {'ε'}
                                if 'ε' not in compute_first(symbol):
                                    break
                            else:
                                first_of_next.add('ε')
                            follow[X] |= first_of_next
                            if 'ε' in first_of_next:
                                follow[X] |= compute_follow(lhs)
                        else:
                            if lhs != X:
                                follow[X] |= compute_follow(lhs)
    return follow[X]

# Main execution
start_symbol = 'S'
for non_terminal in grammar:
    compute_first(non_terminal)
for non_terminal in grammar:
    compute_follow(non_terminal)

# Output
print("FIRST sets:")
for nt in grammar:
    print(f"FIRST({nt}) = {{ {', '.join(first[nt])} }}")

print("\nFOLLOW sets:")
for nt in grammar:
    print(f"FOLLOW({nt}) = {{ {', '.join(follow[nt])} }}")
