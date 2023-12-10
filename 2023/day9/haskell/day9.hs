nextNumber :: [Int] -> Int
nextNumber l = if all (== 0) l then 0 else nextNumber (zipWith (curry (\x -> snd x - fst x)) l (tail l)) + last l

prevNumber :: [Int] -> Int
prevNumber l = if all (== 0) l then 0 else head l - prevNumber (zipWith (curry (\x -> snd x - fst x)) l (tail l))

main = do
  input <- readFile "../input.txt"
  let r = sum $ map (prevNumber . (map read . words)) $ lines input
  print r
  return ()
