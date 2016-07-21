module Modals.RenameFolder exposing (..)

import Html exposing (Html, div, img, text, input)
import Html.Attributes exposing (class, src, placeholder, autofocus, type')
import Html.Events exposing (onClick, onInput)
import Folders.Messages exposing (..)
import Folders.Models exposing (FolderId)
import Utils exposing (onEnter)


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
