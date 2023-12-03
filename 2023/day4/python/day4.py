input = open("2023/day4/input.txt").read().strip().split('\n')

ts = 0
for l in input:
    winners, numbers = l.split(':')[1].split('|')
    winners = [int(x) for x in winners.split()]
    numbers = [int(x) for x in numbers.split()]
    cs = 0
    for n in numbers:
        if n in winners:
            cs = 1 if cs == 0 else cs * 2
    ts += cs

print("part1: ", ts)

copies = [1 for _ in range(len(input))]
for i, l in enumerate(input):
    f,s = l.split(':')
    winners, numbers = s.split('|')
    winners = [int(x) for x in winners.split()]
    numbers = [int(x) for x in numbers.split()]
    
    print(i)
    for j in range(copies[i]):
 
        c = 1
        for n in numbers:
            if n in winners:
                copies[i+c] += 1
                c+=1

s = sum(copies)
print("part2: ", s)