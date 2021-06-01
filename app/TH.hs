{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}
module TH where

import            Data.Convertible

import qualified  Language.Haskell.TH as TH

deriveConvertible :: TH.Name -> TH.Name -> TH.Q [TH.Dec]
deriveConvertible newType otherType = do
  Just newCon <- TH.lookupValueName (TH.nameBase newType)
  v <- TH.newName "v"

  [d|
    instance Convertible $(TH.conT newType) $(TH.conT otherType) where
      safeConvert $(TH.conP newCon [TH.varP v]) = Right $(TH.varE v)

    instance Convertible $(TH.conT otherType) $(TH.conT newType) where
      safeConvert source = Right ($(TH.conE newCon) source)

    |]
