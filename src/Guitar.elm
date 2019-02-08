module Guitar exposing
    ( GuitarNote
    , createGuitarNote
    , findAllOctaves
    , getGuitarNoteName
    , getGuitarNoteWithPitch
    , getGuitarStringName
    , guitarStrings
    , guitarStringsWithPitches
    , isMarkerFret
    , playNoteAudio
    )

import Array
import AudioPorts
import Debug exposing (..)
import Dict exposing (..)
import List.Extra exposing (elemIndex)
import Maybe exposing (withDefault)
import Music exposing (Chord, Note, PitchNotation)


type alias GuitarChord =
    List GuitarNote


type alias GuitarNote =
    { stringNum : Int
    , fretNum : Int
    , stringName : Note
    , noteName : Note
    , pitchNotation : PitchNotation
    }


type alias ChordNote =
    ( Int, Note )


type alias StringSet =
    List Int



-- stringSets = Dict.fromList
--     [    ( "1|3", [4, 5, 6] )
--     ,    ( "2|3", [3, 4, 5] )
--     ,    ( "3|3", [2, 3, 4] )
--     ,    ( "4|3", [1, 2, 3] )
--     ,    ( "1|4", [3, 4, 5, 6] )
--     ,    ( "2|4", [2, 3, 4, 5] )
--     ,    ( "3|4", [1, 2, 3, 4] )
-- "1|B3" : [3, 5, 6],
-- "2|B3" : [2, 4, 5],
-- "3|B3" : [1, 3, 4],
-- "B1|3" : [3, 4, 6],
-- "B2|3" : [2, 3, 5],
-- "B3|3" : [1, 2, 4],
-- ,    ( "1|B4", [2, 4, 5, 6] )
-- ,    ( "2|B4", [1, 3, 4, 5] )
-- "1|B2" : [4, 6],
-- "2|B2" : [3, 5],
-- "3|B2" : [2, 4],
-- "4|B2" : [1, 3],
-- "A|1" : [3, 6],
-- "A|2" : [2, 5],
-- "A|3" : [1, 4],
-- ]
--chordQualityRelativeFretsForStringSet = Dict.fromList
--    [ ( "X|4",
--        [ ( Min7,    [[0, 2, 0, 1], [1, 3, 0, 3], [0, 0, -2, 1], [0, 0, -1, 0]] )
--          ( Min,     [[0, 2, 2, 1], [1, 3, 0, 3], [0, 0, -2, 1], [0, 0, -1, 0]] )
--        -- , ( "m7b5",  [[0, 6, 10, 15], [3, 10, 12, 18], [6, 12, 15, 22], [10, 15, 18, 24]] )
--        -- , ( "o7",    [[0, 6, 9,  15], [3, 9,  12, 18], [6, 12, 15, 21], [9,  15, 18, 24]] )
--        -- , ( "mMaj7", [[0, 7, 11, 15], [3, 11, 12, 19], [7, 12, 15, 23], [11, 15, 19, 24]] )
--        -- , ( "Maj7",  [[0, 7, 11, 16], [4, 11, 12, 19], [7, 12, 16, 23], [11, 16, 19, 24]] )
--        -- , ( '7',     [[0, 7, 10, 16], [4, 10, 12, 19], [7, 12, 16, 22], [10, 16, 19, 24]] )
--        ]
--    --, ( "X|B4", Dict.fromList
--    --     [ ( "m7",    [[0, 10, 15, 19], [3, 12, 19, 22], [7, 15, 22, 24], [10, 19, 24, 27]] )
--    --     , ( "m7b5",  [[0, 10, 15, 18], [3, 12, 18, 22], [6, 15, 22, 24], [10, 18, 24, 27]] )
--    --     , ( "o7",    [[0,  9, 15, 18], [3, 12, 18, 21], [6, 15, 21, 24], [9,  18, 24, 27]] )
--    --     , ( "mMaj7", [[0, 11, 15, 19], [3, 12, 19, 23], [7, 15, 23, 24], [11, 19, 24, 27]] )
--    --     , ( "Maj7",  [[0, 11, 16, 19], [4, 12, 19, 23], [7, 16, 23, 24], [11, 19, 24, 28]] )
--    --     , ( "7",     [[0, 10, 16, 19], [4, 12, 19, 22], [7, 16, 22, 24], [10, 19, 24, 28]] )
--    --     ]
--    -- )
--    ]
-- chordNoteForString : Chord -> Int -> Int -> ChordNote
-- chordNoteForString chord index string =
--     let
--         l = index
--     in
--     ( fret, )
-- chordForString : Chord -> Int -> Int -> GuitarNote
-- chordForString chord index string =
--     let
--         l =
--             log "chord" chord
--         i =
--             log "index" index
--         str =
--             log "string" string
--         stringName =
--             log "stringName"
--                 (guitarStrings
--                     |> Array.fromList
--                     |> Array.get (string - 1)
--                 )
--         getChordNote =
--             log "chordNote" (getChordNoteForString chord string index)
--     in
--     { stringNum = string
--     , stringName = withDefault "" stringName
--     , fretNum = 4
--     , noteName = "D"
--     , pitchNotation = ( "D", 3 )
--     }
-- getGuitarChordNotesByStringSet : Chord -> String -> List GuitarNote
-- getGuitarChordNotesByStringSet chord stringSet =
--     let
--         strings =
--             withDefault [] (Dict.get stringSets stringSet)
--         l =
--             log "strings" strings
--     in
--     List.indexedMap (chordForString chord) strings
-- --     [ { stringNum = 5
-- --       , stringName = "A"
-- --       , fretNum = 4
-- --       , noteName = "D"
-- --       , pitchNotation = ( "D", 3 )
-- --       }
-- --     , { stringNum = 4
-- --       , stringName = "D"
-- --       , fretNum = 6
-- --       , noteName = "A"
-- --       , pitchNotation = ( "A", 3 )
-- --       }
-- --     , { stringNum = 3
-- --       , stringName = "G"
-- --       , fretNum = 6
-- --       , noteName = "C"
-- --       , pitchNotation = ( "C", 4 )
-- --       }
-- --     , { stringNum = 2
-- --       , stringName = "B"
-- --       , fretNum = 5
-- --       , noteName = "F"
-- --       , pitchNotation = ( "F", 4 )
-- --       }
-- --     ]


createGuitarNote : Int -> Int -> GuitarNote
createGuitarNote stringNum fretNum =
    { stringNum = stringNum
    , fretNum = fretNum
    , stringName = getGuitarStringName stringNum
    , noteName = getGuitarNoteName stringNum fretNum
    , pitchNotation = getGuitarNoteWithPitch stringNum fretNum
    }


findAllOctaves : Note -> Int -> List GuitarNote
findAllOctaves note numberOfFrets =
    let
        findMatchingNotes ( stringIndex, _ ) =
            getAllStringNotes (stringIndex + 1) numberOfFrets
                |> List.filter (\n -> n.noteName == note)
    in
    guitarStrings
        |> Array.fromList
        |> Array.toIndexedList
        |> List.concatMap findMatchingNotes


guitarStrings : List Note
guitarStrings =
    [ "E", "B", "G", "D", "A", "E" ]


guitarStringPitches : List Int
guitarStringPitches =
    [ 4, 3, 3, 3, 2, 2 ]


guitarStringsWithPitches : List PitchNotation
guitarStringsWithPitches =
    List.map2 Tuple.pair guitarStrings guitarStringPitches


getGuitarNoteWithPitch : Int -> Int -> PitchNotation
getGuitarNoteWithPitch stringNum fretNum =
    let
        octaveCountInRange =
            List.range 0 fretNum
                |> List.filter (\fret -> getGuitarNoteName stringNum fret == "C")
                |> List.length

        stringPitch =
            guitarStringsWithPitches
                |> Array.fromList
                |> Array.get (stringNum - 1)
                |> withDefault ( "E", -1000 )

        pitch =
            Tuple.second stringPitch + octaveCountInRange

        noteName =
            getGuitarNoteName stringNum fretNum
    in
    ( noteName, pitch )


getAllStringNotes : Int -> Int -> List GuitarNote
getAllStringNotes stringNum numberOfFrets =
    List.range 0 numberOfFrets
        |> List.map (createGuitarNote stringNum)


getGuitarStringName : Int -> Note
getGuitarStringName num =
    let
        guitarString =
            guitarStrings
                |> Array.fromList
                |> Array.get (num - 1)
    in
    withDefault "" guitarString


markerFrets : List Int
markerFrets =
    [ 1, 3, 5, 7, 9, 12, 15, 17, 19, 21, 24 ]


isMarkerFret : Int -> Int -> Bool
isMarkerFret fretNum stringNum =
    stringNum == 3 && (markerFrets |> List.member fretNum)


getGuitarNoteName : Int -> Int -> Note
getGuitarNoteName stringNum fretNum =
    let
        stringName =
            getGuitarStringName stringNum

        stringNoteIndex =
            withDefault 0 (elemIndex stringName Music.notes)

        virtualIndex =
            stringNoteIndex + fretNum

        remainder =
            remainderBy noteCount virtualIndex

        noteCount =
            Music.notes |> List.length

        wholeCycles =
            floor (toFloat virtualIndex / toFloat noteCount)

        selectedNoteIndex =
            if virtualIndex >= noteCount then
                virtualIndex - wholeCycles * noteCount

            else
                virtualIndex
    in
    Music.getNoteNameByIndex selectedNoteIndex


playNoteAudio : GuitarNote -> Cmd msg
playNoteAudio guitarNote =
    guitarNote.pitchNotation
        |> Music.pitchNotationToStr
        |> AudioPorts.playNote
