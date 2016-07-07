module Folders.Views.Tree exposing (..)

import Html exposing (Html, div, img, text)
import Html.Attributes exposing (class, src)
import Html.Events exposing (onClick)
import Folders.Messages exposing (..)
import Folders.Models exposing (SubFolder)


view : { a | current : Maybe (List SubFolder), previous : Maybe (List SubFolder) } -> Html Msg
view folder =
  let
    maybeSubFolders =
      Maybe.oneOf [ folder.previous, folder.current ]
  in
    case maybeSubFolders of
      Just subFolders ->
        div []
          [ div [] (List.map renderSubFolder subFolders)
          ]

      Nothing ->
        renderNothing


renderSubFolder : SubFolder -> Html Msg
renderSubFolder subFolder =
  div [ class "Folder__Tree__container", onClick (NavigateTo subFolder.id) ]
    [ div [ class "Folder__Tree__icon" ] [ img [ src "/assets/small-folder--closed.svg" ] [] ]
    , div [ class "Folder__Tree__name" ] [ text subFolder.name ]
    ]


renderNothing : Html Msg
renderNothing =
  div [] []
