module Folders.Messages exposing (..)

import Http
import Folders.Models exposing (FolderId, Folder)
import Models exposing (ModalName)


type alias InputValue =
  String


type alias ImgSourceName =
  String


type Msg
  = FetchRootDone Folder
  | FetchRootFail Http.Error
  | FetchFolderDone Folder
  | FetchFolderFail Http.Error
  | FetchAndNavigate FolderId
  | ShowModal ModalName
  | CloseModal
  | HandleRenameInputChange InputValue
  | RenameFolder FolderId
  | RenameFail Http.Error
  | RenameSuccess Folder
  | HandleNewFolderInputChange InputValue
  | NewFolder
  | NewFolderFail Http.Error
  | NewFolderSuccess Folder
  | HandleTurkingInputChange InputValue
  | SelectImgSource ImgSourceName
