{-# LANGUAGE DeriveDataTypeable    #-}
{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Lib
    ( TracerRangeInfo(..)
    , tracerRangeInfo
    , tracerRangeInfo'
    ) where

import           Data.Data
import qualified GHC.Generics              as G
import qualified Text.PrettyPrint.Tabulate as T

data TracerRangeInfo = TracerRangeInfo
    { time_        :: Integer
    , firingAngle_ :: Double
    , velocity_    :: Double
    , range_       :: Double
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

-- | Calculates the horizontal distance flown by a projectile with a given firing angle, initial velocity and time passed.
horizontalDistance :: Double -> Double -> Integer -> Double
horizontalDistance angle velocity time = velocity * fromInteger time * cos' angle

-- | Calculates range information (i.e. horizontal distance) for one tracer round / projectile.
tracerRangeInfo :: Double -> Double -> Integer -> TracerRangeInfo
tracerRangeInfo angle velocity time = do
    let shellRange = horizontalDistance angle velocity time
    TracerRangeInfo {
        time_ = time,
        firingAngle_ = angle,
        velocity_ = velocity,
        range_ = shellRange
    }

tracerRangeInfo' :: Double -> Double -> [Integer] -> [TracerRangeInfo]
tracerRangeInfo' angle velocity = map (tracerRangeInfo angle velocity)
