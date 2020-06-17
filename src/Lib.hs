{-# LANGUAGE DeriveDataTypeable    #-}
{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Lib
    ( RangeInfo(..)
    , rangeInfo
    ) where

import           Data.Data
import qualified GHC.Generics              as G
import qualified Text.PrettyPrint.Tabulate as T

data RangeInfo = RangeInfo
    { time_     :: Integer
    , angle_    :: Double
    , velocity_ :: Double
    , range_    :: Double
    } deriving (Data, G.Generic, Show)

-- | Acceleration of gravity
g :: Double
g = 9.80665

-- | Converts from degrees to radians.
radians :: Double -> Double
radians degrees = degrees * (pi / 180)

-- | Calculates the sine of an angle in degrees.
sin' :: Double -> Double
sin' degrees = sin $ radians degrees

-- | Calculates the cosine of an angle in degrees.
cos' :: Double -> Double
cos' degrees = cos $ radians degrees

timeOfFlight :: Double -> Double -> Double -> Double
timeOfFlight angle velocity range = range / (velocity * cos' angle)

maxHorizontalDistance :: Double -> Double -> Double
maxHorizontalDistance angle velocity = velocity ^ 2 * sin' (2 * angle) / g

horizontalDistance :: Double -> Double -> Integer -> Double
horizontalDistance angle velocity time = do
    let maxDistance = maxHorizontalDistance angle velocity
    let distance = velocity * fromInteger time * cos' angle
    min maxDistance distance

rangeInfo :: Double -> Double -> Integer -> RangeInfo
rangeInfo angle velocity time = do
    let shellRange = horizontalDistance angle velocity time
    RangeInfo {
        time_ = time,
        angle_ = angle,
        velocity_ = velocity,
        range_ = shellRange
    }
