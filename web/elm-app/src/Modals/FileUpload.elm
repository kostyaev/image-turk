module Modals.FileUpload exposing (..)

import Html exposing (Html, div, img, text, input)
import Html.Attributes exposing (class, src, placeholder, type')
import Html.Events exposing (onClick)
import Folders.Messages exposing (..)


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
