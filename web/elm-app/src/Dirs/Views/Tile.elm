module Dirs.Views.Tile exposing (..)

import Html exposing (div, img, text)
import Html.Attributes exposing (class, src)
import Dirs.Messages exposing (..)
import Dirs.Models exposing (Dir)


-- view : List Dir -> Html Msg
view dirs =
  div []
    [ div [] (List.map renderDir dirs)
    ]


-- renderDir : List Dir -> Html Msg
renderDir dir =
  div [ class "Dir--Tile--container" ]
    [ div [ class "Dir--Tile--icon" ] [ img [ src "../assets/big-folder--closed.png" ] [] ]
    , div [ class "Dir--Tile--name" ] [ text dir.name ]
    ]
