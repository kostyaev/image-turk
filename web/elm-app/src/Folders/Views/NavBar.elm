module Folders.Views.NavBar exposing (..)

import Html exposing (Html, div, img, text)
import Html.Attributes exposing (class, src)
import Html.Events exposing (onClick, onInput)
import Folders.Messages exposing (..)
import Folders.Views.Modals exposing (renderModal)


view : Maybe String -> { a | id : String } -> Html Msg
view maybeModal folder =
  case maybeModal of
    Just modalName ->
      div []
        [ renderNavBar
        , renderModal modalName folder
        ]

    Nothing ->
      renderNavBar


renderNavBar : Html Msg
renderNavBar =
  div [ class "App__NavBar" ]
    [ div [ class "App__NavBar__container", onClick (ShowModal "new") ]
      [ img [ src "/assets/new-folder.svg" ] []
      , div [ class "App__NavBar__name" ] [ text "New folder" ]
      ]
    , div [ class "App__NavBar__container" ]
      [ img [ src "/assets/move-here.svg" ] []
      , div [ class "App__NavBar__name" ] [ text "Move here" ]
      ]
    , div [ class "App__NavBar__container", onClick (ShowModal "rename") ]
      [ img [ src "/assets/rename-folder.svg" ] []
      , div [ class "App__NavBar__name" ] [ text "Rename current" ]
      ]
    , div [ class "App__NavBar__container", onClick (ShowModal "upload") ]
      [ img [ src "/assets/add-img-zip.svg" ] []
      , div [ class "App__NavBar__name" ] [ text "Add img/zip" ]
      ]
    ]
