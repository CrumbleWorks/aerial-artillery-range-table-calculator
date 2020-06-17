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
    , angle_    :: Integer
    , velocity_ :: Float
    , range_    :: Float
    } deriving (Data, G.Generic, Show)

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
