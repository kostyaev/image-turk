module Dirs.Commands exposing (..)

import Http
import Json.Decode exposing (Decoder, object3, list, int, string, (:=))
import Task
import Dirs.Models exposing (DirId, Dir)
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
  object3 Dir
    ("id" := int)
    ("name" := string)
    ("images" := list string)
