module View exposing (..)

import Html exposing (Html, div, text)
import Html.Attributes exposing (class)
import Html.App
import Messages exposing (Msg(..))
import Models exposing (MainModel)
import Folders.Views.Tile
import Folders.Views.Tree
import Folders.Views.NavBar
import Routing exposing (Route(..))


view : MainModel -> Html Msg
view model =
  case model.route of
    MainRoute ->
      foldersView model

    FolderRoute id ->
      foldersView model

    NotFoundRoute ->
      notFoundView


foldersView : MainModel -> Html Msg
foldersView model =
  let
    maybeFolder =
      model.folder

    maybeModal =
      model.modal
  in
    case maybeFolder of
      Just folder ->
        div [ class "App__container" ]
          [ Html.App.map FoldersMsg (Folders.Views.NavBar.view maybeModal folder)
          , div [ class "App__TreeSide" ]
            [ Html.App.map FoldersMsg (Folders.Views.Tree.view folder)
            ]
          , div [ class "App__TileSide" ]
            [ Html.App.map FoldersMsg (Folders.Views.Tile.view folder)
            ]
          ]

      Nothing ->
        notFoundView


notFoundView : Html msg
notFoundView =
  div [ class "page404__box" ]
    [ div [ class "page404__text" ] [ text "404" ]
    ]
