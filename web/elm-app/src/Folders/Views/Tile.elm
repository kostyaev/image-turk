module Folders.Views.Tile exposing (..)

import Html exposing (Html, div, img, text)
import Html.Attributes exposing (class, src)
import Folders.Messages exposing (..)
import Folders.Models exposing (SubFolder)


view : { a | current : Maybe (List SubFolder) } -> Html Msg
view folder =
  case folder.current of
    Just current ->
      div []
        [ div [] (List.map renderSubFolder current)
        ]

    Nothing ->
      renderNothing


renderSubFolder : SubFolder -> Html Msg
renderSubFolder subFolder =
  div [ class "Folder__Tile__container" ]
    [ div [ class "Folder__Tile__icon" ] [ img [ src "/assets/big-folder--closed.svg" ] [] ]
    , div [ class "Folder__Tile__name" ] [ text subFolder.name ]
    ]


renderNothing : Html Msg
renderNothing =
  div [] []
