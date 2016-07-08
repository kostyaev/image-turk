module Folders.Update exposing (..)

import Folders.Messages exposing (..)
import Folders.Models exposing (Folder)
import Navigation
import Hop exposing (makeUrl)
import Hop.Types exposing (Location)
import Routing


type alias UpdateModel =
  { folders : List Folder
  , location : Location
  }


update : Msg -> UpdateModel -> (UpdateModel, Cmd Msg)
update message model =
  case message of
    FetchAllDone newFolders ->
      let
        newModel =
          ({ model | folders = newFolders })
      in
        (newModel, Cmd.none)

    FetchAllFail error ->
      (model, Cmd.none)

    NavigateToFolder id ->
      let
        cmd =
          Routing.reverse (Routing.FolderRoute id)
            |> makeUrl Routing.config
            |> Navigation.newUrl
      in
        (model, cmd)
