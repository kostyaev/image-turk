module Utils exposing (..)

import Html
import Html.Events exposing (on, keyCode)
import Json.Decode as Json
import Folders.Messages exposing (..)


onEnter : Msg -> Html.Attribute Msg
onEnter msg =
  let
    tagger code =
      if code == 13 then msg else NoOp
  in
    on "keydown" (Json.map tagger keyCode)
