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
    , angle_    :: Float
    , velocity_ :: Float
    , range_    :: Float
    } deriving (Data, G.Generic, Show)

-- | Acceleration of gravity
g :: Float
g = 9.80665

-- | Converts from degrees to radians.
radians :: Float -> Float
radians degrees = degrees * (pi / 180)

-- | Calculates the sine of an angle in degrees.
sin' :: Float -> Float
sin' degrees = sin $ radians degrees

-- | Calculates the cosine of an angle in degrees.
cos' :: Float -> Float
cos' degrees = cos $ radians degrees

timeOfFlight :: Float -> Float -> Float -> Float
timeOfFlight angle velocity range = range / (velocity * cos' angle)

maxHorizontalDistance :: Float -> Float -> Float
maxHorizontalDistance angle velocity = velocity ^ 2 * sin' (2 * angle) / g

horizontalDistance :: Float -> Float -> Integer -> Float
horizontalDistance angle velocity time = do
    let maxDistance = maxHorizontalDistance angle velocity
    let distance = velocity * fromInteger time * cos' angle
    min maxDistance distance

rangeInfo :: Float -> Float -> Integer -> RangeInfo
rangeInfo angle velocity time = do
    let shellRange = horizontalDistance angle velocity time
    RangeInfo {
        time_ = time,
        angle_ = angle,
        velocity_ = velocity,
        range_ = shellRange
    }
