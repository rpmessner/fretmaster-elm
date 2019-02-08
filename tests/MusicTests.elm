module MusicTests exposing (testGetNoteNameByIndex, testPitchNotationToStr)

import Expect
import Music exposing (ChordQuality(..), getChordByRoot, getChordByRootQuality, getChordByRootQualityInversion, getNoteNameByIndex, pitchNotationToStr)
import Test exposing (..)


testPitchNotationToStr : Test
testPitchNotationToStr =
    describe "pitchNotationToStr"
        [ test "returns SPN as a string" <|
            \_ ->
                Expect.equal "E2" (pitchNotationToStr ( "E", 2 ))
        , test "returns SPN with sharps/flats as flats" <|
            \_ ->
                Expect.equal "Bb2" (pitchNotationToStr ( "A#/Bb", 2 ))
        ]


testGetNoteNameByIndex : Test
testGetNoteNameByIndex =
    describe "testGetNoteNameByIndex"
        [ test "returns 'A' for 0" <|
            \_ ->
                Expect.equal "A" (getNoteNameByIndex 0)
        , test "returns 'B' for 2" <|
            \_ ->
                Expect.equal "B" (getNoteNameByIndex 2)
        , test "returns 'C' for 3" <|
            \_ ->
                Expect.equal "C" (getNoteNameByIndex 3)
        , test "returns 'E' for 7" <|
            \_ ->
                Expect.equal "E" (getNoteNameByIndex 7)
        , test "returns 'F' for 8" <|
            \_ ->
                Expect.equal "F" (getNoteNameByIndex 8)
        , test "returns 'Err!' for out of range" <|
            \_ ->
                Expect.equal "Err!" (getNoteNameByIndex 100)
        ]


testGetChordByRoot : Test
testGetChordByRoot =
    describe "getChordByRoot"
        [ test "returns with default quality & inversion" <|
            \_ ->
                Expect.equal { root = "A", quality = Maj, inversion = 0 } (getChordByRoot "A")
        ]


testGetChordByRootQuality : Test
testGetChordByRootQuality =
    describe "getChordByRootQuality"
        [ test "returns with default inversion" <|
            \_ ->
                Expect.equal { root = "A", quality = Min, inversion = 0 } (getChordByRootQuality "A" Min)
        ]


testGetChordByRootQualityInversion : Test
testGetChordByRootQualityInversion =
    describe "getChordByRootQualityInversion"
        [ test "returns with supplied attrs" <|
            \_ ->
                Expect.equal { root = "A", quality = Min, inversion = 1 } (getChordByRootQualityInversion "A" Min 1)
        ]
