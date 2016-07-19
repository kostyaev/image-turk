module Folders.Messages exposing (..)

import Http
import Folders.Models exposing (FolderId, Folder)
import Models exposing (ModalName)


type Msg
  = FetchRootDone Folder
  | FetchRootFail Http.Error
  | FetchFolderDone Folder
  | FetchFolderFail Http.Error
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
