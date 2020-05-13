trans :: Char -> Char
trans c = if c == '\t'
          then '@'
          else c

expand :: String -> String
expand chars = map trans chars

main = do cs <- getContents
          putStrLn $ expand cs
