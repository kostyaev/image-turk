module Modals.View exposing (..)

import Html exposing (Html, div)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Folders.Messages exposing (..)
import Folders.Models exposing (FolderId, ModalName)
import Models exposing (ImgSource, SearchResults)
import Modals.Search exposing (renderSearchView)
import Modals.FileUpload exposing (renderFileUploadView)
import Modals.RenameFolder exposing (renderRenameFolderView)
import Modals.NewFolder exposing (renderNewFolderView)


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
        "turking" -> renderSearchView selectedSource searchResults
        _ -> div [] []
  in
    div []
      [ div [ class "Modal__dialog" ]
          [ body
          ]
      , div [ class "Modal__back", onClick CloseModal ] []
      ]
