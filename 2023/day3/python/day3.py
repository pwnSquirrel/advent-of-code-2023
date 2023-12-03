import re

numbers_r = re.compile("\d+")
symbols_r = re.compile("[^\.0-9]")

def part1(input):
    numbers = {}
    symbols = {}
    m = [[]]
    for i,l in enumerate(input):
        for s in re.finditer(numbers_r, l):
            numbers[(i, s.start(), s.end())] = s[0]
        for s in re.finditer(symbols_r, l):
            symbols[(i, s.start())] = s[0]

    sum = 0
    for k,v in numbers.items():
        if check_around(symbols, k[0], k[1], k[2]):
            sum += int(v)
    
    return sum

def check_around(symbols, l, s, e):
    print(l, s, e)
    if (l, s-1) in symbols or (l, e) in symbols:
        return True
    
    for x in range(s-1,e+1):
        print(x)
        if (l-1, x) in symbols or (l+1, x) in symbols:
            return True

    return False

gears_r = re.compile("\*")


def part2(input):
    numbers = {}
    gears = {}
    m = [[]]
    for i,l in enumerate(input):
        for s in re.finditer(numbers_r, l):
            for x in range(s.start(), s.end()):
                numbers[(i, x)] = s[0]
        for s in re.finditer(gears_r, l):
            gears[(i, s.start())] = s[0]

    sum = 0
    for g in gears:
        sum += find_around(numbers, g[0], g[1])
    
    return sum

def find_around(n, l, x):
    first = 0
    for c in [(l, x-1), (l, x+1), (l-1, x-1), (l-1, x), (l-1, x+1), (l+1, x-1), (l+1, x), (l+1, x+1)]:
        if c in n:
            if first == 0:
                first = int(n[c])
            elif int(n[c]) != first:
                return int(n[c]) * first

    return 0
    
input = ["." * 142]
input += ["." + x + "." for x in open("2023/day3/input.txt").read().strip().split('\n')]
input += ["." * 142]

print("Part1: ", part1(input))
print("Part 2: ", part2(input))
