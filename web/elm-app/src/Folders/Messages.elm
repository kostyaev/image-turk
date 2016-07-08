module Folders.Messages exposing (..)

import Http
import Folders.Models exposing (FolderId, Folder)


type Msg
  = FetchAllDone (List Folder)
  | FetchAllFail Http.Error
  | NavigateToFolder FolderId
