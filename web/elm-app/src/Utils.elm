module Utils exposing (..)

import Html
import Html.Events exposing (on, keyCode)
import Json.Decode as Json
import Json.Decode exposing (Decoder, object1, object2, object6, list, string, (:=), maybe)
import Folders.Messages exposing (..)
import Folders.Models exposing (Folder, ImageRecord, SubFolder)
import Models exposing (SearchResults)


onEnter : Msg -> Html.Attribute Msg
onEnter msg =
  let
    tagger code =
      if code == 13 then msg else NoOp
  in
    on "keydown" (Json.map tagger keyCode)


apiUrl : String
apiUrl =
  "http://localhost:5000/api/dirs/"


serverUrl : String
serverUrl =
  "http://localhost:5000/"


memberDecoder : Decoder Folder
memberDecoder =
  object6 Folder
    ("id" := string)
    ("name" := string)
    (maybe ("images" := list imageDecoder))
    (maybe ("siblings" := list folderDecoder))
    (maybe ("children" := list folderDecoder))
    ("parent_id" := string)


imageDecoder : Decoder ImageRecord
imageDecoder =
  object2 ImageRecord
    ("id" := string)
    ("url" := string)


folderDecoder : Decoder SubFolder
folderDecoder =
  object2 SubFolder
    ("id" := string)
    ("name" := string)


imagesListDecoder : Decoder SearchResults
imagesListDecoder =
  object1 SearchResults ("images" := list imageDecoder)
