module Modals.Commands exposing (..)

import Http
import Task
import Folders.Models exposing (FolderId, FolderName, Folder)
import Models exposing (SaveImageResult)
import Folders.Messages exposing (..)
import Json.Encode as ToJson
import Utils exposing (serverUrl, imagesListDecoder, apiUrl, memberDecoder, statusDecoder)


fetchImages : String -> String -> Cmd Msg
fetchImages source query =
  let
    query =
      Http.url (serverUrl ++ "/api/search") [ ("source", source), ("query", query) ]
  in
    Http.get imagesListDecoder query
      |> Task.perform FetchImagesFail FetchImagesDone


saveImg : String -> String -> String -> Cmd Msg
saveImg imgId url folderId =
  saveImgTask imgId url folderId
    |> Task.perform SaveImgFail SaveImgSuccess


saveImgTask : String -> String -> String -> Platform.Task Http.Error SaveImageResult
saveImgTask imgId url folderId =
  let
    body =
      ToJson.object
        [ ("image_id", ToJson.string imgId)
        , ("url", ToJson.string url)
        , ("dir_id", ToJson.string folderId)
        ]
        |> ToJson.encode 0
        |> Http.string

    config =
      { verb = "POST"
      , headers = [ ( "Content-Type", "application/json" ) ]
      , url = serverUrl ++ "/api/images"
      , body = body
      }
  in
    Http.send Http.defaultSettings config
      |> Http.fromJson statusDecoder


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
