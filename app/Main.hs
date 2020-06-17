{-# LANGUAGE MultiParamTypeClasses #-}

import           Lib
import qualified Text.PrettyPrint.Tabulate as T

instance T.Tabulate TracerRangeInfo T.DoNotExpandWhenNested

main :: IO ()
main = do
    let velocity = 800
    let angle = 20
    let measurements = [5,10..60]

    let rangeInfos = map (tracerRangeInfo angle velocity) measurements

    T.printTable rangeInfos
