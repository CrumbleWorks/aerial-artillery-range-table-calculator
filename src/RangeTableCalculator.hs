{-# LANGUAGE DeriveDataTypeable    #-}
{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module RangeTableCalculator where

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

timeOfFlight :: Integer -> Float -> Float -> Float
timeOfFlight angle velocity range = range / (velocity * cos (fromIntegral angle))

distance :: Integer -> Float -> Integer -> Float
distance angle velocity time = velocity * fromInteger time * cos (fromIntegral angle)

rangeInfo :: Integer -> Float -> Integer -> RangeInfo
rangeInfo angle velocity time = do
    let shellRange = distance angle velocity time
    RangeInfo {
        time_ = time,
        angle_ = angle,
        velocity_ = velocity,
        range_ = shellRange
    }
