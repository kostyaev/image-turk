module Folders.Commands exposing (..)

import Http
import Json.Decode exposing (Decoder, object2, object6, list, int, string, (:=), maybe)
import Json.Encode as ToJson
import Task
import Folders.Models exposing (FolderId, Folder, ImageRecord, SubFolder)
import Folders.Messages exposing (..)


foldersRepo : String
foldersRepo =
  "http://localhost:4000/folders/"


fetchAll : Cmd Msg
fetchAll =
  Http.get collectionDecoder foldersRepo
    |> Task.perform FetchAllFail FetchAllDone


fetchOne : FolderId -> Cmd Msg
fetchOne id =
  let
    query =
      foldersRepo ++ toString id
  in
    Http.get memberDecoder query
      |> Task.perform FetchOneFail FeatchOneDone


collectionDecoder : Decoder (List Folder)
collectionDecoder =
  list memberDecoder


memberDecoder : Decoder Folder
memberDecoder =
  object6 Folder
    ("id" := int)
    ("name" := string)
    (maybe ("images" := list imageDecoder))
    (maybe ("siblings" := list folderDecoder))
    (maybe ("children" := list folderDecoder))
    (maybe ("parent" := int))


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



-- MODALS COMMANDS


renameTask : FolderId -> String -> Platform.Task Http.Error Folder
renameTask folderId name =
  let
    body =
      ToJson.object [ ("name", ToJson.string name) ]
        |> ToJson.encode 0
        |> Http.string

    config =
      { verb = "PATCH"
      , headers = [ ( "Content-Type", "application/json" ) ]
      , url = "http://localhost:4000/folders/" ++ (toString folderId)
      , body = body
      }
  in
    Http.send Http.defaultSettings config
      |> Http.fromJson memberDecoder


rename : FolderId -> String -> Cmd Msg
rename folderId newName =
  renameTask folderId newName
    |> Task.perform RenameFail RenameSuccess


createFolderTask : String -> Platform.Task Http.Error Folder
createFolderTask name =
  let
    body =
      ToJson.object [ ("name", ToJson.string name) ]
        |> ToJson.encode 0
        |> Http.string

    config =
      { verb = "POST"
      , headers = [ ( "Content-Type", "application/json" ) ]
      , url = "http://localhost:4000/folders/"
      , body = body
      }
  in
    Http.send Http.defaultSettings config
      |> Http.fromJson memberDecoder


createFolder : String -> Cmd Msg
createFolder folderName =
  createFolderTask folderName
    |> Task.perform NewFolderFail NewFolderSuccess
