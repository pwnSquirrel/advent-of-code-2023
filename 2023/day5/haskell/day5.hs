import Data.List
import Data.List.Split

getSingleMapping :: [Int] -> Int -> Maybe Int
getSingleMapping [d, s, r] v = if v >= d && v < d + r then Just $ s + (v - d) else Nothing
getSingleMapping _ _ = Nothing

-- map a value
getMapping :: [[Int]] -> Int -> Maybe Int
getMapping (m : ms) v = case getSingleMapping m v of
  Just o -> Just o
  Nothing -> getMapping ms v
getMapping [] v = Just v

-- has this value (after all mappings applied)a corresponding seed or not?
checkSeed :: [Int] -> Int -> Bool
checkSeed [s, r] v = v >= s && v < s + r
checkSeed _ _ = False

-- does a path exist for this value?
hasPath :: [[[Int]]] -> [[Int]] -> Int -> Bool
hasPath [] (s : seeds) v = checkSeed s v || hasPath [] seeds v
hasPath [] [] v = False
hasPath (m : maps) seeds v = case getMapping m v of
  Just o -> hasPath maps seeds o
  Nothing -> False

-- loop through locations beginning from low - we are looking for the lowest number
loopLocations :: [[[Int]]] -> [[Int]] -> Int -> Int
loopLocations maps seeds i =
  if hasPath maps seeds i then i else loopLocations maps seeds (i + 1)

main = do
  -- file must have the string lines removed and the first line split into a seed range entry per
  -- line
  input <- readFile "../input.txt"
  let r = map (map read . words) (lines input) :: [[Int]]
  let seeds : maps = splitWhen null r

  print seeds
  print $ reverse maps
  -- do some pivoting with bigger steps to find a rough number, then search by increasing by one
  let lowest = loopLocations (reverse maps) seeds 23738000

  print lowest
  return ()
