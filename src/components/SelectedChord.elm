module SelectedChord exposing (render)
import Game exposing (GameMode(..))
import Html exposing (Html, button, div, text)
import Model exposing (Model)
import Msg exposing (Msg(..))

render : Model -> Html Msg
render model =
    let
        gameMode = 
            model.gameMode
    in
    case gameMode of
       GuessChord ->
            div []
                [ text "Selected Chord" ]

       _ -> text ""
