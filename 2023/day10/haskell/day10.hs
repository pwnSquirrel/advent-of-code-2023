{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore "Use bimap" #-}
import Data.List

findNext :: Char -> (Int, Int) -> (Int, Int)
findNext c from =
  case c of
    '|' -> (0, -1 * snd from)
    '-' -> (-1 * fst from, 0)
    'L' -> if from == (0, -1) then (1, 0) else (0, -1)
    'J' -> if from == (0, -1) then (-1, 0) else (0, -1)
    '7' -> if from == (0, 1) then (-1, 0) else (0, 1)
    'F' -> if from == (0, 1) then (1, 0) else (0, 1)
    _ -> error "Invalid character"

findStart :: [[Char]] -> (Int, Int)
findStart grid =
  let Just y = findIndex (elem 'S') grid
      Just x = elemIndex 'S' $ grid !! y
   in (x, y)

walkLoop :: [[Char]] -> (Int, Int) -> (Int, Int) -> Int -> Int
walkLoop grid pos prev count =
  let c = grid !! snd pos !! fst pos
      d = (fst prev - fst pos, snd prev - snd pos)
      nextD = findNext c d
      next = (fst pos + fst nextD, snd pos + snd nextD)
   in if c == 'S' then count else walkLoop grid next pos $ count + 1

-- findStartDirection :: [[Char]] -> (Int, Int) -> (Int, Int)
-- findStartDirection grid pos =

main = do
  input <- readFile "../input.txt"
  let grid = lines input
  let count = walkLoop grid (93, 25) (93, 24) 1
  print $ count `div` 2
