{-# OPTIONS_GHC -Wno-incomplete-patterns #-}

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

walkLoop :: [[Char]] -> (Int, Int) -> (Int, Int) -> [(Int, Int)] -> [(Int, Int)]
walkLoop grid (px, py) (lx, ly) loop =
  let ch = grid !! py !! px
      (nx, ny) = findNext ch (lx, ly)
      next = (px + nx, py + ny)
   in if ch == 'S'
        then (px, py) : loop
        else walkLoop grid next (negate nx, negate ny) $ (px, py) : loop

-- shoelace theorem gives complete area
shoeLace :: [(Int, Int)] -> Int
shoeLace [_] = 0
shoeLace ((x1, y1) : (x2, y2) : xs) = (y1 + y2) * (x2 - x1) + shoeLace ((x2, y2) : xs)

part1 grid =
  let (startx, starty) = findStart grid
   in -- TODO find starting direction
      flip div 2 $ length $ walkLoop grid (startx, starty + 1) (0, -1) []

part2 :: [String] -> Int
part2 grid =
  let (startx, starty) = findStart grid
      loop = walkLoop grid (startx, starty + 1) (0, -1) []
   in -- picks theorem gives inner points
      (abs (shoeLace loop) - length loop + 2) `div` 2

main = do
  input <- readFile "../input.txt"
  let grid = lines input
  print $ part1 grid
  print $ part2 grid
