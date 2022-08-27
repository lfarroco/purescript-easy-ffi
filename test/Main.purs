module Test.Main where

import Effect (Effect)
import Effect.Console (log)
import Data.Array (sort)
import Data.Foreign.SmallFFI (unsafeForeignFunction)
import Test.QuickCheck (quickCheck)
import Prelude (Unit, const, discard, ($), (+), (==))

ffi :: forall a. Array String -> String -> a
ffi = unsafeForeignFunction

easyConst :: Int -> Int -> Int
easyConst = ffi [ "n", "" ] "n"

easyAdd :: Int -> Int -> Int
easyAdd = ffi [ "x", "y" ] "x + y"

easySort :: Array Int -> Array Int
easySort = ffi [ "xs" ] "xs.slice().sort(function(a,b){return a-b;})"

main :: Effect Unit
main = do
  log "Constant"
  quickCheck $ \n m -> easyConst n m == const n m
  log "Addition"
  quickCheck $ \n m -> easyAdd n m == n + m
  log "Sorting"
  quickCheck $ \xs -> easySort xs == sort xs
