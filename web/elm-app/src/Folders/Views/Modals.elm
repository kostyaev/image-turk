module Folders.Views.Modals exposing (..)

import Html exposing (Html, div, img, text, input)
import Html.Attributes exposing (class, src, placeholder, autofocus, type')
import Html.Events exposing (onClick, onInput)
import Folders.Messages exposing (..)


renderModal : String -> { a | id : String } -> Html Msg
renderModal name folder =
  let
    body =
      case name of
        "rename" -> renderRenameFolderView folder
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
    , input [ onInput HandleNewFolderInputChange
            , type' "text"
            , class "input"
            , placeholder "...please enter a name"
            , autofocus True
            ] []
    , div [ class "btn", onClick NewFolder ] [ text "Create" ]
    , div [ class "btn--cancel", onClick CloseModal ] [ text "Cancel" ]
    ]


renderRenameFolderView : { a | id : String } -> Html Msg
renderRenameFolderView folder =
  div [ class "Modal__dialog__rename" ]
    [ div [ class "Modal__dialog__title" ]
        [ img [ src "/assets/rename-folder.svg" ] []
        , div [ class "Modal__dialog__title__name" ] [ text "Rename current" ]
        ]
    , input [ onInput HandleRenameInputChange
            , type' "text"
            , class "input"
            , placeholder "...please enter a new name"
            , autofocus True
            ] []
    , div [ class "btn", onClick (RenameFolder folder.id) ] [ text "Save" ]
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
