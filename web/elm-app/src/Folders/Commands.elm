module Folders.Commands exposing (..)

import Http
import Json.Decode exposing (Decoder, object2, object6, list, int, string, (:=), maybe)
import Json.Encode as ToJson
import Task
import Folders.Models exposing (FolderId, FolderName, Folder, ImageRecord, SubFolder)
import Folders.Messages exposing (..)


apiUrl : String
apiUrl =
  "http://localhost:5000/api/dirs/"


serverUrl : String
serverUrl =
  "http://localhost:5000/"


fetchRoot : Cmd Msg
fetchRoot =
  Http.get memberDecoder apiUrl
    |> Task.perform FetchRootFail FetchRootDone


fetchFolder : FolderId -> Cmd Msg
fetchFolder id =
  let
    query =
      apiUrl ++ id
  in
    Http.get memberDecoder query
      |> Task.perform FetchFolderFail FetchFolderDone


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



-- MODALS COMMANDS


renameTask : FolderId -> FolderName -> Platform.Task Http.Error Folder
renameTask folderId name =
  let
    body =
      ToJson.object [ ("name", ToJson.string name) ]
        |> ToJson.encode 0
        |> Http.string

    config =
      { verb = "PATCH"
      , headers = [ ( "Content-Type", "application/json" ) ]
      , url = apiUrl ++ (toString folderId)
      , body = body
      }
  in
    Http.send Http.defaultSettings config
      |> Http.fromJson memberDecoder


rename : FolderId -> FolderName -> Cmd Msg
rename folderId newName =
  renameTask folderId newName
    |> Task.perform RenameFail RenameSuccess


createFolderTask : FolderName -> FolderId -> Platform.Task Http.Error Folder
createFolderTask name parent =
  let
    body =
      ToJson.object [ ("name", ToJson.string name) ]
        |> ToJson.encode 0
        |> Http.string

    config =
      { verb = "POST"
      , headers = [ ( "Content-Type", "application/json" ) ]
      , url = apiUrl ++ parent
      , body = body
      }
  in
    Http.send Http.defaultSettings config
      |> Http.fromJson memberDecoder


createFolder : FolderName -> FolderId -> Cmd Msg
createFolder folderName parent =
  createFolderTask folderName parent
    |> Task.perform NewFolderFail NewFolderSuccess
