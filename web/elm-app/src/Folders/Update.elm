module Folders.Update exposing (..)

import Folders.Messages exposing (Msg(..))
import Folders.Models exposing (Folder)
import Navigation


update : Msg -> List Folder -> ( List Folder, Cmd Msg )
update message folders =
  case message of
    FetchAllDone newFolders ->
      ( newFolders, Cmd.none )

    FetchAllFail error ->
      ( folders, Cmd.none )

    GoFolder id ->
      (folders, Navigation.modifyUrl ("#/" ++ (toString id)))
