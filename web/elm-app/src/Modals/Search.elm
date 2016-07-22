module Modals.Search exposing (..)

import Html exposing (Html, div, img, text, input)
import Html.Attributes exposing (class, classList, src, placeholder, autofocus, type')
import Html.Events exposing (onClick, onInput)
import Folders.Messages exposing (..)
import Folders.Models exposing (ImageRecord)
import Models exposing (SearchResults)
import Utils exposing (onEnter)


renderSearchView : String -> Maybe SearchResults -> Html Msg
renderSearchView selectedSource searchResults =
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
  let
    imgClassName =
      case imgRecord.status of
        Just status ->
          classList
            [ ("Modal__turking__results__img", True)
            , ("Modal__turking__results__img--saving", status == "saving")
            , ("Modal__turking__results__img--saved", status == "saved")
            ]

        Nothing ->
          class "Modal__turking__results__img"
  in
    div [ imgClassName, onClick (SaveImg imgRecord) ]
      [ img [ src imgRecord.url ] []
      ]
