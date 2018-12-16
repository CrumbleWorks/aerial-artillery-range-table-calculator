{-# LANGUAGE MultiParamTypeClasses #-}

import           Data.Data
import qualified GHC.Generics              as G
import           LatexGenerator
import           RangeTableCalculator
import qualified Text.PrettyPrint.Tabulate as T

main :: IO ()
main = do
    --print "Luftschiff, yo."

    let velocity = 800
    let angle = 20
    let measurements = [30, 31 .. 40]

    let rangeInfos = map (rangeInfo angle velocity) measurements

    renderDocument "output/test.tex" $ rangeTable rangeInfos

    {-let d1 = distance 20 800 60
    putStrLn $ (show d1) ++ "m"

    let t1 = airtime 20 800 19587.94
    putStrLn $ (show t1) ++ "s"

    let r1 = rangeInfo 20 800 60
    putStrLn $ show r1-}

    T.printTable rangeInfos
