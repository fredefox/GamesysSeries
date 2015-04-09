-- | Test suite for the implementation.
--
-- Normally I would write my test-cases in QuickCheck, but since I have
-- specifically been asked to do unit-testing, this is what is included here.
--
-- TODO: Currently this does *not* perform automatic testing.
import System.Environment (withArgs)
import Control.Monad
import qualified GamesysSeries

main = do
    let target = GamesysSeries.main
        tests =
            [ -- First test
              ( ["1", "5062.5", "5", "1000", "160"]
              , (1.62, 2.5, [1.5, 4.0, 6.5, 10.75, 17.25], 6.5, 6.5)
              )
            , -- Second test
              ( ["2", "5e4", "5", "100", "80"]
              , (2.88, 13.888889, [3.0,40.0,115.25,331.75,955.5], 115.25, 3.0)
              )
            -- TODO: Add more...
            ]
        run (inp, expected) = do
            putStrLn "# Test case"
            putStrLn ("# Input: " ++ show inp)
            outp <- withArgs inp target
            putStrLn ""
            return $ outp == expected
    results <- forM tests run
    let successes = foldl (\acc x -> if x then succ acc else acc) 0 results
        tests_performed = length tests
    putStrLn "# Test Results"
    putStrLn $ (show successes) ++ " of " ++ (show tests_performed)
        ++ " test cases passed."
