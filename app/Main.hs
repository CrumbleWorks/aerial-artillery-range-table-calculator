{-# LANGUAGE DeriveDataTypeable    #-}
{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE MultiParamTypeClasses #-}

import           Data.Data
import qualified GHC.Generics              as G
import qualified Text.PrettyPrint.Tabulate as T

data RangeInfo = RangeInfo
    { time_     :: Integer
    , angle_    :: Integer
    , velocity_ :: Float
    , range_    :: Float
    } deriving (Data, G.Generic, Show)
instance T.Tabulate RangeInfo T.DoNotExpandWhenNested

-- | Converts from degrees to radians.
radians :: Float -> Float
radians degrees = degrees * (pi / 180)

-- | Calculates the cosine of an angle in degrees.
cos' :: Float -> Float
cos' degrees = cos $ radians degrees

timeOfFlight :: Integer -> Float -> Float -> Float
timeOfFlight angle velocity range = range / (velocity * cos (fromIntegral angle))

distance :: Integer -> Float -> Integer -> Float
distance angle velocity time = velocity * fromInteger time * cos' (fromIntegral angle)

rangeInfo :: Integer -> Float -> Integer -> RangeInfo
rangeInfo angle velocity time = do
    let shellRange = distance angle velocity time
    RangeInfo {
        time_ = time,
        angle_ = angle,
        velocity_ = velocity,
        range_ = shellRange
    }

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
