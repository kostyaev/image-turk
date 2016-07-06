module Dirs.Commands exposing (..)

import Http
import Json.Decode exposing (Decoder, object2, object5, list, int, string, (:=))
import Task
import Dirs.Models exposing (DirId, Dir, ImageRecord, DirRecord)
import Dirs.Messages exposing (..)


fetchAllUrl =
  "http://localhost:4000/dirs"


fetchAll : Cmd Msg
fetchAll =
  Http.get collectionDecoder fetchAllUrl
    |> Task.perform FetchAllFail FetchAllDone


collectionDecoder : Decoder (List Dir)
collectionDecoder =
  list memberDecoder


memberDecoder : Decoder Dir
memberDecoder =
  object5 Dir
    ("id" := int)
    ("name" := string)
    ("images" := list imageDecoder)
    ("current" := list dirDecoder)
    ("previous" := list dirDecoder)


imageDecoder : Decoder ImageRecord
imageDecoder =
  object2 ImageRecord
    ("id" := int)
    ("url" := string)


dirDecoder : Decoder DirRecord
dirDecoder =
  object2 DirRecord
    ("id" := int)
    ("name" := string)
