module View exposing (..)

import Html exposing (Html, div, text)
import Html.Attributes exposing (class)
import Html.App
import Messages exposing (Msg(..))
import Models exposing (Model)
import Dirs.Views.Tile
import Dirs.Views.Tree


view : Model -> Html Msg
view model =
  div [ class "App--container" ]
    [ div [ class "App--TreeSide" ]
      [ div [ class "App--TreeNav" ] []
      , renderTreeView model
      ]
    , div [ class "App--TileSide" ]
      [ div [ class "App--TileNav" ] []
      , renderTileView model
      ]
    ]


renderTileView : Model -> Html Msg
renderTileView model =
  Html.App.map DirsMsg (Dirs.Views.Tile.view model.dirs)


renderTreeView : Model -> Html Msg
renderTreeView model =
  Html.App.map DirsMsg (Dirs.Views.Tree.view model.dirs)
