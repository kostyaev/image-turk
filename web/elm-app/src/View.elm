module View exposing (..)

import Html exposing (Html, div, text)
import Html.Attributes exposing (class)
import Html.App
import Messages exposing (Msg(..))
import Models exposing (Model)
import Dirs.Views.Tile
import Dirs.Views.Tree
import Routing exposing (Route(..))


view : Model -> Html Msg
view model =
  div []
    [ renderView model ]


-- renderView : Model -> Html Msg
renderView model =
  case model.route of
    DirsRoute ->
      mainLayout model 0

    DirRoute id ->
      mainLayout model id

    NotFoundRoute ->
      notFoundView


-- mainLayout : Model -> Int -> Html Msg
mainLayout model dirId =
  let
    maybeDir =
      model.dirs
        |> List.filter (\dir -> dir.id == dirId)
        |> List.head
  in
    case maybeDir of
      Just dir ->
        div [ class "App--container" ]
          [ div [ class "App--TreeSide" ]
            [ div [ class "App--TreeNav" ] []
            , Html.App.map DirsMsg (Dirs.Views.Tree.view dir)
            ]
          , div [ class "App--TileSide" ]
            [ div [ class "App--TileNav" ] []
            , Html.App.map DirsMsg (Dirs.Views.Tile.view dir)
            ]
          ]

      Nothing ->
        notFoundView


notFoundView : Html msg
notFoundView =
  div []
    [ text "Not found"
    ]
