module GamesysSeries (growth, first, series, main) where

import System.Environment

import Data.List (sort)

-- | 'first' calculates the first number in the sequence
first :: Float -> Float
first x = (((x^2) / 2) + (30 * x) + 10) / 25

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

-- | 'closest' find's the element in @xs@ closest to @a@.
closest :: Float -> [Float] -> Maybe Float
closest a xs = v where
    (v, _) = foldl closest' (Nothing, inf) xs
    closest' :: (Maybe Float, Float) -> Float -> (Maybe Float, Float)
    closest' prev@(v, d) x = let curr@(_, d') = (Just x, abs (x - a)) in
        if d' < d
            then curr
            else prev
    inf = 1/0 -- Constructor for infinity

main = do
    -- Part 1
    -- ======
    (x':y0':l':y1':z':_) <- getArgs
    let x   = read x'
        y0  = read y0'
        l   = read l'
        y1  = read y1' :: Float
        z   = read z' :: Float
        fs  = first x
        gr  = growth fs y0
        xs  = take l $ series x y0
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
    -- Part 2
    -- ======
    -- Part two asks for the "product of the following function"
    -- I will assume that what was actually meant was *result*
    -- and not the *product*
    let n1 = let l = length xs'' in
            if l < 3
                then error "Series is not long enough"
                else xs'' !! (l - 3)
        cand    = y1 / z
        -- We can assume that there will be a closest element -
        -- we have just checked if the list is at least 3 elements long
        Just cl = closest cand xs''
    putStrLn $ "Third largest " ++ show n1
    putStrLn $ "Candidate: " ++ show cand
    putStrLn $ "Closest: " ++ show cl
    return
        ( fs
        , gr
        , xs''
        , n1
        , cl
        )
