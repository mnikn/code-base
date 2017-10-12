def permutations(seq):
    if seq == []:
        return [[]]
    solutions = []
    for i in range(len(seq)):
        sub_solutions = permutations(seq[0:i] + seq[i+1:])
        for sub_solution in sub_solutions:
            solutions.append([seq[i]] + sub_solution)
    return solutions

print (permutations([1,2,3]))

