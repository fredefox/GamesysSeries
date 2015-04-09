module GamesysSeries (growth, first, series) where

import System.Environment

import Data.List (sort)

-- | 'first' calculates the first number in the sequence
first :: Float -> Float
first x = ((0.5 * (x**2)) + (30 * x) + 10) / 25

-- | 'growth' assumes that it's first input @x@ is the first number
-- i.e. *not* the parameter to 'first'.
growth :: Float -> Float -> Float
growth x y = 0.02 * y / (25 * x)

-- | 'series' takes as parameters @x@ and @y@ that are the parameters
-- used to calculate the first number and the growth rate. Series returns
-- an infinite list.
--
-- To actually follow the spec 'series' should take as -- parameter an integer
-- specifying the length of the input. This can, however, easily be acheived
-- with:
--
-- @
--     take l $ series x y
-- @
--
-- Where @l@ is the length of the output.
series :: Float -> Float -> [Float]
series x y =
    let fs = first x
        gr = growth fs y
        srs :: Int -> [Float]
        srs i = gr * (fs ^ i) : (srs $ succ i)
    in fs : srs 1

main = do
    (x':y':l':_) <- getArgs
    let x   = read x'
        y   = read y'
        l   = read l' :: Int
        fs  = first x
        gr  = growth fs y
        xs  = take l $ series x y
        -- TODO: Now, there might be a subtlety in the assignment calling for
        -- a solutions that does not perform perform sorting.
        -- One alternative approach is this:
        --
        --  1 <= x          => series x y # is sorted
        --  0 <= x && x < 1 => series x y # is in reverse
        -- -1 <= x && x < 0 => series x y # is in reverse,
        --                                  except for alternation
        --            x < 1 => series x y # is sorted,
        --                                  except for alternation
        xs' = sort xs
        rnd x = (fromIntegral $ round (x*4)) / 4
        xs'' = map rnd xs'
    putStrLn $ "First: "  ++ show fs
    putStrLn $ "Growth: " ++ show gr
    putStrLn $ "Series: " ++ show xs
    putStrLn $ "- sorted: " ++ show xs'
    putStrLn $ "- rounded: " ++ show xs''
