module Folders.Messages exposing (..)

import Http
import Folders.Models exposing (FolderId, Folder, ImageRecord)
import Models exposing (ModalName, SearchResults, SaveImageResult)


type alias InputValue =
  String


type alias ImgSourceName =
  String


type Msg
  = NoOp
  | FetchRootDone Folder
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
  | FetchImages
  | FetchImagesFail Http.Error
  | FetchImagesDone SearchResults
  | SaveImg ImageRecord
  | SaveImgFail Http.Error
  | SaveImgSuccess SaveImageResult
