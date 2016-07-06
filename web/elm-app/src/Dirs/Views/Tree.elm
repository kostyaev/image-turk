module Dirs.Views.Tree exposing (..)

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
  div [ class "Dir--Tree--container" ]
    [ div [ class "Dir--Tree--icon" ] [ img [ src "/assets/small-folder--closed.svg" ] [] ]
    , div [ class "Dir--Tree--name" ] [ text dir.name ]
    ]
