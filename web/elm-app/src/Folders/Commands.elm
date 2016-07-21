module Folders.Commands exposing (..)

import Http
import Task
import Folders.Models exposing (FolderId)
import Folders.Messages exposing (..)
import Utils exposing (memberDecoder, apiUrl)


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
