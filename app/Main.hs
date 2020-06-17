{-# LANGUAGE MultiParamTypeClasses #-}

import           Lib
import qualified Text.PrettyPrint.Tabulate as T

instance T.Tabulate RangeInfo T.DoNotExpandWhenNested

main :: IO ()
main = do
    --print "Luftschiff, yo."

    let velocity = 800
    let angle = 20
    --let measurements = [30,31..60]
    let measurements = [5,10..60]

    let rangeInfos = map (rangeInfo angle velocity) measurements

    {-let d1 = distance 20 800 60
    putStrLn $ (show d1) ++ "m"

    let t1 = airtime 20 800 19587.94
    putStrLn $ (show t1) ++ "s"

    let r1 = rangeInfo 20 800 60
    putStrLn $ show r1-}

    T.printTable rangeInfos
