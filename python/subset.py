def subset(seq):
    if len(seq) == 0:
        return [[]]
    remains = subset(seq[1:])
    return remains + map(lambda item: [seq[0]] + item,remains)
