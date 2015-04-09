module GamesysSeries (growth, first, series) where
import Debug.Trace

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
