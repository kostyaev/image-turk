module Modals.Commands exposing (..)

import Http
import Task
import Folders.Models exposing (FolderId, FolderName, Folder)
import Folders.Messages exposing (..)
import Json.Encode as ToJson
import Utils exposing (serverUrl, imagesListDecoder, apiUrl, memberDecoder)


fetchImages : String -> String -> Cmd Msg
fetchImages source query =
  let
    query =
      Http.url (serverUrl ++ "/api/search") [ ("source", source), ("query", query) ]
  in
    Http.get imagesListDecoder query
      |> Task.perform FetchImagesFail FetchImagesDone


renameFolder : FolderId -> FolderName -> Cmd Msg
renameFolder folderId newName =
  renameTask folderId newName
    |> Task.perform RenameFail RenameSuccess


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



createFolder : FolderName -> FolderId -> Cmd Msg
createFolder folderName parent =
  createFolderTask folderName parent
    |> Task.perform NewFolderFail NewFolderSuccess


createFolderTask : FolderName -> FolderId -> Platform.Task Http.Error Folder
createFolderTask name parent =
  let
    body =
      ToJson.object [ ("dir_name", ToJson.string name) ]
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
