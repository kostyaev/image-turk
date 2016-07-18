module Folders.Messages exposing (..)

import Http
import Folders.Models exposing (FolderId, Folder)
import Models exposing (ModalName)


type Msg
  = FetchAllDone (List Folder)
  | FetchAllFail Http.Error
  | FeatchOneDone Folder
  | FetchOneFail Http.Error
  | FetchAndNavigate FolderId
  | ShowModal ModalName
  | CloseModal
  | HandleRenameInputChange String
  | RenameFolder FolderId
  | RenameFail Http.Error
  | RenameSuccess Folder
  | HandleNewFolderInputChange String
  | NewFolder
  | NewFolderFail Http.Error
  | NewFolderSuccess Folder
