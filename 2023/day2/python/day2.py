def part1(input):
    sum = 0
    for l in input:
        f,s = l.split(':')
        n = int(f.split()[1])
        ok = True

        for st in s.split(';'):
            for e in st.split(','):
                count, color = e.split()
                ok = ok and (
                    (color == "red" and int(count) <= 12)
                    or (color == "green" and int(count) <= 13)
                    or (color == "blue" and int(count) <= 14))
        sum += int(ok) * n
    return sum

def part2(input):
    sum = 0
    for l in input:
        d = {"red" : 0, "green": 0, "blue" : 0}
        for st in l.split(':')[1].split(';'):
            for e in st.split(','):
                count, color = e.split()
                d[color] = max(d[color], int(count))

        sum += d["red"]*d["green"]*d["blue"]
    return sum

input = open("../input.txt").read().strip().split('\n')

print("Part1:", part1(input))
print("Part2:", part2(input))
