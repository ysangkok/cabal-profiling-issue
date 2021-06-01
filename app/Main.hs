{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
module Main where

import            TH

newtype Wrapper = Wrapper Int

deriveConvertible ''Wrapper ''Int

main :: IO ()
main = putStrLn "Hello, Haskell!"
