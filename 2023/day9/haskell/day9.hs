import Control.Monad
import Data.List.Split (splitOn)
import Data.String
import System.IO
import Text.Printf (printf)

nextNumber :: [Int] -> Int
nextNumber l = if all (== 0) l then 0 else nextNumber (zipWith (curry (\x -> snd x - fst x)) l (tail l)) + last l

prevNumber :: [Int] -> Int
prevNumber l = if all (== 0) l then 0 else head l - prevNumber (zipWith (curry (\x -> snd x - fst x)) l (tail l))

processLine :: String -> Int
processLine = prevNumber . map read . splitOn " "

walkLines :: Handle -> Int -> IO Int
walkLines f s = do
  eof <- hIsEOF f
  if eof
    then return s
    else do
      l <- hGetLine f
      walkLines f $ processLine l + s

main = do
  f <- openFile "../input.txt" ReadMode
  r <- walkLines f 0
  printf "%d\n" r
  return ()
