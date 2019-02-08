module Msg exposing (Msg(..))

import Game exposing (GameMode)
import Guitar exposing (GuitarNote)


type Msg
    = ChangeGameMode GameMode
    | GuitarNoteClicked Int Int
    | PickRandomNote
    | PickRandomChord
    | RandomGuitarNoteSelected GuitarNote
    | ShowNoteInfo
    | ShowOctavesChanged Bool
    | NoOp
