# Preprocess input by removing all text
input = open("2023/day5/test.txt").read().strip().split('\n')

# part 1
seeds = input[0].split()
maps = []
c = -1
for l in input[1:]:
    if l == "":
        maps.append([]) 
        c += 1
        continue

    d,s,r = l.split()
    maps[c].append((int(d),int(s),int(r)))


res = []
for seed in seeds:
    seed = int(seed)
    for m in maps:
        for d,s,r in m:
            t = seed - s
            if t in range(r):
                seed = d + t
                break
    res.append(seed)

print("part1: ", min(res))

# part 2
it = iter(input[0].split())
seeds = [(x, next(it)) for x in it]

maps = []
for l in input[1:]:
    if l == "":
        maps.append([]) 
        c += 1
        continue

    d,s,r = l.split()
    maps[c].append((int(d),int(s),int(r)))

print(seeds)
