module Folders.Views.NavBar exposing (..)

import Html exposing (Html, div, img, text, input, a)
import Html.Attributes exposing (class, src, placeholder)
import Html.Events exposing (onClick, onInput)
import Folders.Messages exposing (..)


view : Maybe String -> Html Msg
view maybeModal =
  case maybeModal of
    Just modalName ->
      div []
        [ renderNavBar
        , renderModal modalName
        ]

    Nothing ->
      renderNavBar


renderNavBar : Html Msg
renderNavBar =
  div [ class "App__NavBar" ]
    [ div [ class "App__NavBar__container" ]
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
    , div [ class "App__NavBar__container" ]
      [ img [ src "/assets/add-img-zip.svg" ] []
      , div [ class "App__NavBar__name" ] [ text "Add img/zip" ]
      ]
    ]


renderModal : String -> Html Msg
renderModal name =
  let
    body =
      if name == "rename" then
        renameModal
      else
        div [] []
  in
    div [ class "Modal__back" ]
      [ div [ class "Modal__dialog" ]
        [ body
        ]
      ]


renameModal : Html Msg
renameModal =
  div [ class "Modal__dialog__rename" ]
    [ input [ class "input", placeholder "...please enter new name" ] []
    , div [ class "btn" ] [ text "Save" ]
    , div [ class "btn--cancel", onClick CloseModal ] [ text "Cancel" ]
    ]
