module Folders.Commands exposing (..)

import Http
import Json.Decode exposing (Decoder, object2, object5, list, int, string, (:=), maybe)
import Task
import Folders.Models exposing (FolderId, Folder, ImageRecord, SubFolder)
import Folders.Messages exposing (..)


fetchAllUrl : String
fetchAllUrl =
  "http://localhost:4000/folders"


fetchAll : Cmd Msg
fetchAll =
  Http.get collectionDecoder fetchAllUrl
    |> Task.perform FetchAllFail FetchAllDone


collectionDecoder : Decoder (List Folder)
collectionDecoder =
  list memberDecoder


memberDecoder : Decoder Folder
memberDecoder =
  object5 Folder
    ("id" := int)
    ("name" := string)
    (maybe ("images" := list imageDecoder))
    (maybe ("current" := list folderDecoder))
    (maybe ("previous" := list folderDecoder))


imageDecoder : Decoder ImageRecord
imageDecoder =
  object2 ImageRecord
    ("id" := int)
    ("url" := string)


folderDecoder : Decoder SubFolder
folderDecoder =
  object2 SubFolder
    ("id" := int)
    ("name" := string)
