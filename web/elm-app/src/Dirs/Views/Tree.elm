module Dirs.Views.Tree exposing (..)

import Html exposing (Html, div, img, text)
import Html.Attributes exposing (class, src)
import Dirs.Messages exposing (..)
import Dirs.Models exposing (SubDir)


view : { a | current : Maybe (List SubDir), previous : Maybe (List SubDir) } -> Html Msg
view dir =
  let
    maybeSubDirs =
      Maybe.oneOf [ dir.previous, dir.current ]
  in
    case maybeSubDirs of
      Just subDirs ->
        div []
          [ div [] (List.map renderSubDir subDirs)
          ]

      Nothing ->
        renderNothing


renderSubDir : SubDir -> Html Msg
renderSubDir subDir =
  div [ class "Dir--Tree--container" ]
    [ div [ class "Dir--Tree--icon" ] [ img [ src "/assets/small-folder--closed.svg" ] [] ]
    , div [ class "Dir--Tree--name" ] [ text subDir.name ]
    ]


renderNothing : Html Msg
renderNothing =
  div [] []
