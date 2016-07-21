module Folders.Views.Modals exposing (..)

import Html exposing (Html, div, img, text, input)
import Html.Attributes exposing (class, classList, src, placeholder, autofocus, type')
import Html.Events exposing (onClick, onInput)
import Folders.Messages exposing (..)
import Folders.Models exposing (Folder, FolderId, ModalName, ImageRecord)
import Models exposing (ImgSource, SearchResults)
import Utils exposing (onEnter)


renderModal : ModalName -> FolderId -> Maybe ImgSource -> Maybe SearchResults -> Html Msg
renderModal name folderId imgSource searchResults =
  let
    selectedSource =
      case imgSource of
        Just imgSource -> imgSource
        Nothing -> "google"

    body =
      case name of
        "rename" -> renderRenameFolderView folderId
        "new" -> renderNewFolderView
        "upload" -> renderFileUploadView
        "turking" -> renderTurkingView selectedSource searchResults
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
            , onEnter NewFolder
            ] []
    , div [ class "btn", onClick NewFolder ] [ text "Create" ]
    , div [ class "btn--cancel", onClick CloseModal ] [ text "Cancel" ]
    ]


renderRenameFolderView : FolderId -> Html Msg
renderRenameFolderView folderId =
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
            , onEnter (RenameFolder folderId)
            ] []
    , div [ class "btn", onClick (RenameFolder folderId) ] [ text "Save" ]
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


renderTurkingView : String -> Maybe SearchResults -> Html Msg
renderTurkingView selectedSource searchResults =
  let
    btnClassName source =
      classList
        [ ("Modal__turking__filters__btn", True)
        , ("Modal__turking__filters__btn--selected", selectedSource == source)
        ]

    images =
      case searchResults of
        Just results -> results.images
        Nothing -> []
  in
  div [ class "Modal__dialog__turking" ]
    [ div [ class "Modal__dialog__title" ]
        [ img [ src "/assets/turking_cloud.svg" ] []
        , div [ class "Modal__dialog__title__name" ] [ text "Search images" ]
        ]
    , input [ onInput HandleTurkingInputChange
            , type' "text"
            , class "input"
            , placeholder "...what do you want to find?"
            , autofocus True
            , onEnter FetchImages
            ] []
    , div [ class "Modal__turking__filters" ]
      [ div
          [ btnClassName "google"
          , onClick (SelectImgSource "google")
          ]
          [ text "Google" ]
      , div
          [ btnClassName "flickr"
          , onClick (SelectImgSource "flickr")
          ]
          [ text "Flickr" ]
      , div
          [ btnClassName "bing"
          , onClick (SelectImgSource "bing")
          ]
          [ text "Bing" ]
      , div
          [ btnClassName "instagram"
          , onClick (SelectImgSource "instagram")
          ]
          [ text "Instagram" ]
      , div
          [ btnClassName "yandex"
          , onClick (SelectImgSource "yandex")
          ]
          [ text "Yandex" ]
      , div
          [ btnClassName "imagenet"
          , onClick (SelectImgSource "imagenet")
          ]
          [ text "Imagenet" ]
      ]
    , div [ class "btn__container" ]
        [ div [ class "btn", onClick FetchImages ] [ text "FETCH" ]
        , div [ class "btn--cancel", onClick CloseModal ] [ text "Exit" ]
        ]
    , div [ class "Modal__turking__results" ] (List.map renderSearchResult images)
    ]


renderSearchResult : ImageRecord -> Html Msg
renderSearchResult imgRecord =
  div [ class "Modal__turking__results__img" ]
    [ img [ src imgRecord.url ] []
    ]
