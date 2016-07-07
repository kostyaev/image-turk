module Dirs.Commands exposing (..)

import Http
import Json.Decode exposing (Decoder, object2, object5, list, int, string, (:=), maybe)
import Task
import Dirs.Models exposing (DirId, Dir, ImageRecord, SubDir)
import Dirs.Messages exposing (..)


fetchAllUrl : String
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
    (maybe ("images" := list imageDecoder))
    (maybe ("current" := list dirDecoder))
    (maybe ("previous" := list dirDecoder))


imageDecoder : Decoder ImageRecord
imageDecoder =
  object2 ImageRecord
    ("id" := int)
    ("url" := string)


dirDecoder : Decoder SubDir
dirDecoder =
  object2 SubDir
    ("id" := int)
    ("name" := string)
