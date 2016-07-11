module Folders.Views.Tile exposing (..)

import Html exposing (Html, div, img, text)
import Html.Attributes exposing (class, src)
import Folders.Messages exposing (..)
import Folders.Models exposing (SubFolder, ImageRecord)


type alias TileView a =
  { a
  | siblings : Maybe (List SubFolder)
  , images : Maybe (List ImageRecord)
  }


view : TileView a -> Html Msg
view folder =
  let
    subFolders =
      case folder.siblings of
        Just siblings ->
          List.map renderSubFolder siblings

        Nothing ->
          []

    images =
      case folder.images of
        Just images ->
          List.map renderImages images

        Nothing ->
          []
    in
      div [ class "Folder__Tile__container" ] (subFolders ++ images)


renderSubFolder : SubFolder -> Html Msg
renderSubFolder subFolder =
  div [ class "Folder__Tile__folder-container" ]
    [ div [ class "Folder__Tile__icon" ] [ img [ src "/assets/big-folder--closed.svg" ] [] ]
    , div [ class "Folder__Tile__name" ] [ text subFolder.name ]
    ]


renderImages : { a | url : String } -> Html Msg
renderImages image =
  img [ class "Folder__Tile__image", src image.url ] []


renderNothing : Html Msg
renderNothing =
  div [] []
