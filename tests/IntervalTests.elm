module IntervalTests exposing (testGetSemitonesFromInterval)

import Expect
import Interval exposing (getPitchFromRootInterval, getSemitonesFromInterval)
import Test exposing (..)


testGetPitchFromRootInterval : Test
testGetPitchFromRootInterval =
    describe "getPitchFromRootInterval"
        [ test "transposes octave in C" <|
            \_ ->
                Expect.equal "C" ( getPitchFromRootInterval "C", "O" )
        , test "transposes 2m in C" <|
            \_ ->
                Expect.equal "Db" ( getPitchFromRootInterval "C", "2m" )
        , test "transposes 2M in B" <|
            \_ ->
                Expect.equal "C#" ( getPitchFromRootInterval "B", "2M" )
        , test "transposes 2M in C" <|
            \_ ->
                Expect.equal "D" ( getPitchFromRootInterval "C", "2M" )
        ]


testGetSemitonesFromInterval : Test
testGetSemitonesFromInterval =
    describe "getSemitonesFromInterval"
        [ test "returns semitones for 2m interval" <|
            \_ ->
                Expect.equal 1 (getSemitonesFromInterval "2m")
        , test "returns semitones for 2M interval" <|
            \_ ->
                Expect.equal 2 (getSemitonesFromInterval "2M")
        , test "returns semitones for 3m interval" <|
            \_ ->
                Expect.equal 3 (getSemitonesFromInterval "3m")
        , test "returns semitones for 3M interval" <|
            \_ ->
                Expect.equal 4 (getSemitonesFromInterval "3M")
        , test "returns semitones for 4p interval" <|
            \_ ->
                Expect.equal 5 (getSemitonesFromInterval "4p")
        ]
