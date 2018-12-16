{-# LANGUAGE OverloadedStrings #-}

module LatexGenerator (rangeTable, renderDocument) where

import           RangeTableCalculator         as RTC
import qualified Text.LaTeX                   as TeX
import qualified Text.LaTeX.Base.Commands     as TeX
import qualified Text.LaTeX.Base.Syntax       as TeX
import qualified Text.LaTeX.Packages.Inputenc as TeX
import qualified Text.LaTeX.Packages.TabularX as TeX

toLaTeX :: Show a => a -> TeX.LaTeX
toLaTeX = TeX.fromString . show

preamble :: TeX.LaTeX
preamble =
    TeX.documentclass [] TeX.article
    <> TeX.usepackage [TeX.utf8] TeX.inputenc
    <> TeX.usepackage [] TeX.tabularxp
    <> TeX.author "Michael Stocker, Patrick Bächli"
    <> TeX.title "Aerial Artillery Range Tables"

renderDocument :: String -> TeX.LaTeX -> IO ()
renderDocument filename body = TeX.renderFile filename $ preamble <> TeX.document body

rangeTableHead :: TeX.LaTeX
rangeTableHead = "time" TeX.& "angle" TeX.& "velocity" TeX.& "range" <> TeX.tabularnewline <> TeX.hline

rangeTableRow :: RTC.RangeInfo -> TeX.LaTeX
rangeTableRow rangeInfo =
    toLaTeX (RTC.time_ rangeInfo) TeX.&
    toLaTeX (RTC.angle_ rangeInfo) TeX.&
    toLaTeX (RTC.velocity_ rangeInfo) TeX.&
    toLaTeX (RTC.range_ rangeInfo) <> TeX.tabularnewline

rangeTable :: [RTC.RangeInfo] -> TeX.LaTeX
rangeTable rangeInfos =
    TeX.tabular
        Nothing
        [TeX.VerticalLine, TeX.CenterColumn, TeX.VerticalLine,  TeX.CenterColumn, TeX.VerticalLine, TeX.CenterColumn, TeX.VerticalLine, TeX.NameColumn "S", TeX.VerticalLine]
        (rangeTableHead <> foldMap rangeTableRow rangeInfos)
