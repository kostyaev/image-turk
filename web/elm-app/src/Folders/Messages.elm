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
