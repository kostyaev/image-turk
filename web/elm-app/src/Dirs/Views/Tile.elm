module Dirs.Views.Tile exposing (..)

import Html exposing (Html, div, img, text)
import Html.Attributes exposing (class, src)
import Dirs.Messages exposing (..)
import Dirs.Models exposing (SubDir)


view : { a | current : Maybe (List SubDir) } -> Html Msg
view dir =
  case dir.current of
    Just current ->
      div []
        [ div [] (List.map renderSubDir current)
        ]

    Nothing ->
      renderNothing


renderSubDir : SubDir -> Html Msg
renderSubDir subDir =
  div [ class "Dir--Tile--container" ]
    [ div [ class "Dir--Tile--icon" ] [ img [ src "/assets/big-folder--closed.svg" ] [] ]
    , div [ class "Dir--Tile--name" ] [ text subDir.name ]
    ]


renderNothing : Html Msg
renderNothing =
  div [] []
