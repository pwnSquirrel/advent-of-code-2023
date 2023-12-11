import Data.List
import Data.Tuple

parseGrid :: [[Char]] -> [(Int, Int)]
parseGrid grid = [(x, y) | (y, l) <- zip [0 ..] grid, (x, c) <- zip [0 ..] l, c == '#']

expBeyond :: Int -> Int -> [(Int, Int)] -> [(Int, Int)]
expBeyond amount i gs
  | i `notElem` map fst gs = map (\(a, b) -> (if a >= i then a + amount - 1 else a, b)) gs
  | otherwise = gs

expFstDim :: Int -> Int -> [(Int, Int)] -> [(Int, Int)]
expFstDim amount i gs
  | i >= 0 = expFstDim amount (i - 1) (expBeyond amount i gs)
  | otherwise = gs

sumDist :: Int -> [(Int, Int)] -> Int
sumDist s ((x0, y0) : gs) = sum ([abs (x - x0) + abs (y - y0) | (x, y) <- gs]) + sumDist s gs
sumDist s [] = 0

solve :: Int -> [(Int, Int)] -> Int
solve expandAmount gs =
  let expX = expFstDim expandAmount (maximum (map fst gs)) gs
      expXY = map swap $ expFstDim expandAmount (maximum (map snd gs)) (map swap expX)
   in sumDist 0 expXY

main = do
  input <- readFile "../input.txt"
  let gs = parseGrid $ lines input
  -- part1
  print $ solve 2 gs
  -- part2
  print $ solve 1000000 gs
