module Modals.NewFolder exposing (..)

import Html exposing (Html, div, img, text, input)
import Html.Attributes exposing (class, src, placeholder, autofocus, type')
import Html.Events exposing (onClick, onInput)
import Folders.Messages exposing (..)
import Utils exposing (onEnter)


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
