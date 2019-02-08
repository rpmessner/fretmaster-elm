module Interval exposing (getPitchFromInterval, getSemitonesFromInterval)

import List.Extra exposing (elemIndex, getAt)
import Math exposing (modBy)
import Music exposing (Note)


type alias Interval =
    String


getPitchFromRootInterval : Note -> Interval -> Maybe Note
getPitchFromRootInterval root interval =
    let
        semitones =
            getSemitonesFromInterval interval

        rootIndex =
            elemIndex notes root
    in
    case rootIndex of
        Just index ->
            getNoteNameByIndex (modBy 12 (index + semitones))

        Nothing ->
            Nothing


getSemitonesFromInterval : String -> Int
getSemitonesFromInterval interval =
    case interval of
        "2m" ->
            1

        "2p" ->
            2

        "2M" ->
            2

        "3m" ->
            3

        "3M" ->
            4

        "4p" ->
            5

        "4a" ->
            6

        "4#" ->
            6

        "#4" ->
            6

        "b5" ->
            6

        "5b" ->
            6

        "5p" ->
            7

        "5a" ->
            8

        "5#" ->
            8

        "#5" ->
            8

        "6m" ->
            8

        "6M" ->
            9

        "7bb" ->
            9

        "7b" ->
            10

        "7m" ->
            10

        "7M" ->
            11

        "O" ->
            12

        _ ->
            0
