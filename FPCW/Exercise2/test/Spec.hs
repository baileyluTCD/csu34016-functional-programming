{-# LANGUAGE StandaloneDeriving #-}

module Main where

import Ex2
import Test.Framework as TF (
    Test,
    defaultMain,
    testGroup,
 )
import Test.Framework.Providers.HUnit (testCase)
import Test.Framework.Providers.QuickCheck2 (testProperty)
import Test.HUnit
import Test.QuickCheck (Gen, Positive, Property, arbitrary, forAll, (.||.), (===))
import Test2Support

main = defaultMain tests
tests :: [TF.Test]
tests =
    [ testGroup
        "TEST Ex2 helpers"
        [ testCase
            "every empty with empty list"
            ( Ex2.every 10 ([] :: [Int]) @?= []
            )
        , testCase
            "every returns a sequence of multiples of two"
            ( Ex2.every 2 [1 .. 20] @?= [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]
            )
        , testCase
            "every returns a sequence of multiples of three"
            ( Ex2.every 3 [1 .. 20] @?= [3, 6, 9, 12, 15, 18]
            )
        ]
    , testGroup
        "TEST Ex2 f1"
        [ testCase
            "empty with empty list"
            ( Ex2.f1 ([] :: [Int]) @?= []
            )
        , testCase
            "empty for less than 390"
            ( Ex2.f1 [1 .. 350] @?= []
            )
        , testCase
            "takes every 390th value"
            ( Ex2.f1 [1 .. 2000] @?= [390, 780, 1170, 1560, 1950]
            )
        , testProperty
            "f1 returns only numbers divisible by 390"
            prop_f1Divisible
        ]
    , testGroup
        "TEST Ex2 f2"
        [ testCase
            "zero with empty list"
            ( Ex2.f2 [] @?= 0
            )
        , testCase
            "zero for less than 177"
            ( Ex2.f2 [1 .. 150] @?= 0
            )
        , testCase
            "sum is 177 when max is 177"
            ( Ex2.f2 [1 .. 177] @?= 177
            )
        , testCase
            "sum is 177 * 3 when max is 354"
            ( Ex2.f2 [1 .. (354)] @?= 177 * 3
            )
        , testProperty
            "f1 returns only numbers which are multiples of 177"
            prop_f2Multiple
        ]
    , testGroup
        "TEST Ex2 f3"
        [ testCase
            "one with empty list"
            ( Ex2.f3 [] @?= 1
            )
        , testCase
            "one for less than 288"
            ( Ex2.f3 [1 .. 250] @?= 1
            )
        , testCase
            "sum is 288 when max is 288"
            ( Ex2.f3 [1 .. 288] @?= 288
            )
        , testCase
            "sum is 288 * (288 * 2) when max is 576"
            ( Ex2.f3 [1 .. (576)] @?= 165888
            )
        , testProperty
            "f1 returns only numbers which are multiples of 288"
            prop_f3Multiple
        ]
    ]

-- | `f1` should return a list where every element is a multiple of 390.
prop_f1Divisible :: [Int] -> Property
prop_f1Divisible xs =
    let result = Ex2.f1 xs
     in all (\x -> x `mod` 390 == 0) result === True

-- | `f2` should return result that is a multiple of `177`.
prop_f2Multiple :: [Int] -> Property
prop_f2Multiple xs =
    let result = Ex2.f2 xs
     in result `mod` 177 === 0

-- | `f3` should return result that is a multiple of `288`.
prop_f3Multiple :: [Int] -> Property
prop_f3Multiple xs =
    let result = Ex2.f3 xs
     in result `mod` 288 === 0 .||. result === 1
