module View exposing (view)

import Fretboard
import GameControls
import Header
import Html exposing (Html, div)
import Html.Attributes exposing (class)
import Model exposing (Model)
import Msg exposing (Msg(..))
import SelectedNote
import SelectedChord


view : Model -> Html Msg
view model =
    div [ class "main" ]
        [ Header.render
        , Fretboard.render model
        , GameControls.render model
        , SelectedNote.render model
        , SelectedChord.render model
        ]
