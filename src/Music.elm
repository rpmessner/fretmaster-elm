module Music exposing (Chord, ChordQuality(..), Note, PitchNotation, getChordByRoot, getChordByRootQuality, getChordByRootQualityInversion, getNoteNameByIndex, notes, pitchNotationToStr)

import Array
import Maybe exposing (withDefault)


type alias Note =
    String


type alias PitchNotation =
    ( String, Int )


notes : List Note
notes =
    [ "A", "A#/Bb", "B", "C", "C#/Db", "D", "D#/Eb", "E", "F", "F#/Gb", "G", "G#/Ab" ]


pitchNotationToStr : PitchNotation -> String
pitchNotationToStr spn =
    let
        normalizedNoteName =
            spn
                |> Tuple.first
                |> String.split "/"
                |> List.reverse
                |> List.head
                |> withDefault "ERROR!"

        pitchString =
            spn
                |> Tuple.second
                |> String.fromInt
    in
    [ normalizedNoteName, pitchString ]
        |> String.join ""


getNoteNameByIndex : Int -> Note
getNoteNameByIndex index =
    let
        noteName =
            notes
                |> Array.fromList
                |> Array.get index
    in
    withDefault "Err!" noteName


type alias Chord =
    { root : String
    , quality : ChordQuality
    , inversion : Int
    }


type ChordQuality
    = Maj
    | Min
    | Maj7
    | Maj6
    | Maj9
    | Min7
    | Min6
    | Min9
    | Dom7
    | Min7b5
    | Dim
    | Dim7
    | Dom7b9
    | Dom7b5
    | Dom7Aug


getChordByRootQualityInversion : String -> ChordQuality -> Int -> Chord
getChordByRootQualityInversion root quality inversion =
    { root = root
    , inversion = inversion
    , quality = quality
    }


getChordByRootQuality : String -> ChordQuality -> Chord
getChordByRootQuality root quality =
    getChordByRootQualityInversion root quality 0


getChordByRoot : String -> Chord
getChordByRoot root =
    getChordByRootQualityInversion root Maj 0
