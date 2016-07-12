module Folders.Views.Tree exposing (..)

import Html exposing (Html, div, img, text)
import Html.Attributes exposing (class, src)
import Html.Events exposing (onClick)
import Folders.Messages exposing (..)
import Folders.Models exposing (SubFolder, FolderId, Folder)


type alias TreeView a =
  { a
  | siblings : Maybe (List SubFolder)
  , children : Maybe (List SubFolder)
  , parent : Maybe FolderId
  , name : String
  }


view : TreeView a -> Html Msg
view folder =
  let
    maybeSubFolders =
      Maybe.oneOf [ folder.children, folder.siblings ]

    name =
      folder.name
  in
    case maybeSubFolders of
      Just subFolders ->
        div []
          [ div []
              [ renderBackButton folder.parent
              , renderOpenedFolder name
              , div [] (List.map renderSubFolder subFolders)
              ]
          ]

      Nothing ->
        renderNothing


renderSubFolder : SubFolder -> Html Msg
renderSubFolder subFolder =
  div [ class "Folder__Tree__container", onClick (FetchAndNavigate subFolder.id) ]
    [ div [ class "Folder__Tree__icon" ] [ img [ src "/assets/small-folder--closed.svg" ] [] ]
    , div [ class "Folder__Tree__name" ] [ text subFolder.name ]
    ]


renderNothing : Html Msg
renderNothing =
  div [] []


renderBackButton : Maybe FolderId -> Html Msg
renderBackButton maybeParent =
  case maybeParent of
    Just parent ->
      div [ class "App__TreeNav__back-icon", onClick (FetchAndNavigate parent) ] []

    Nothing ->
      renderNothing


renderOpenedFolder : String -> Html a
renderOpenedFolder name =
  div [ class "Folder__Tree__container--open" ]
    [ div [ class "Folder__Tree__icon" ] [ img [ src "/assets/small-folder--open.svg" ] [] ]
    , div [ class "Folder__Tree__name" ] [ text name ]
    ]
