module Folders.Views.NavBar exposing (..)

import Html exposing (Html, div, img, text, input, a)
import Html.Attributes exposing (class, src, placeholder, autofocus, type')
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


renderModal : String -> Html Msg
renderModal name =
  let
    body =
      case name of
        "rename" -> renderRenameFolderView
        "new" -> renderNewFolderView
        "upload" -> renderFileUploadView
        _ -> div [] []
  in
    div []
      [ div [ class "Modal__dialog" ]
          [ body
          ]
      , div [ class "Modal__back", onClick CloseModal ] []
      ]


renderNewFolderView : Html Msg
renderNewFolderView =
  div [ class "Modal__dialog__rename" ]
    [ div [ class "Modal__dialog__title" ]
        [ img [ src "/assets/new-folder.svg" ] []
        , div [ class "Modal__dialog__title__name" ] [ text "New folder" ]
        ]
    , input [ type' "text", class "input", placeholder "...please enter name", autofocus True ] []
    , div [ class "btn" ] [ text "Create" ]
    , div [ class "btn--cancel", onClick CloseModal ] [ text "Cancel" ]
    ]


renderRenameFolderView : Html Msg
renderRenameFolderView =
  div [ class "Modal__dialog__rename" ]
    [ div [ class "Modal__dialog__title" ]
        [ img [ src "/assets/rename-folder.svg" ] []
        , div [ class "Modal__dialog__title__name" ] [ text "Rename current" ]
        ]
    , input [ type' "text", class "input", placeholder "...please enter a new name", autofocus True ] []
    , div [ class "btn" ] [ text "Save" ]
    , div [ class "btn--cancel", onClick CloseModal ] [ text "Cancel" ]
    ]


renderFileUploadView : Html Msg
renderFileUploadView =
  div [ class "Modal__dialog__upload" ]
    [ div [ class "Modal__dialog__title" ]
        [ img [ src "/assets/add-img-zip.svg" ] []
        , div [ class "Modal__dialog__title__name" ] [ text "Add img/zip" ]
        ]
    , div [ class "Upload__area" ]
      [ img [ class "Upload__area__img", src "/assets/add-img-zip--big.svg" ] []
      , div [ class "Upload__area__title" ]
        [ div [ class "Upload__area__title--drag" ] [ text "Drag and Drop" ]
        , div [ class "Upload__area__title--select" ] [ text "or click to select files" ]
        ]
      , input [ type' "file", class "file-input", placeholder "...add a file" ] []
      ]
    , div [ class "btn" ] [ text "Upload" ]
    , div [ class "btn--cancel", onClick CloseModal ] [ text "Cancel" ]
    ]
