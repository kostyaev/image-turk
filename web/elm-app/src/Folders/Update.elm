module Folders.Update exposing (..)

import Folders.Messages exposing (..)
import Folders.Models exposing (Folder)
import Navigation
import Hop exposing (makeUrl)
import Hop.Types exposing (Location)
import Routing
import Folders.Commands exposing (fetchOne)


type alias UpdateModel =
  { folders : List Folder
  , location : Location
  , modal : Maybe String
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

    FeatchOneDone newFolder ->
      let
        newModel =
          ({ model | folders = [newFolder] })

        navigateCmd =
          Routing.reverse (Routing.FolderRoute newFolder.id)
            |> makeUrl Routing.config
            |> Navigation.newUrl
      in
        (newModel, navigateCmd)

    FetchOneFail error ->
      (model, Cmd.none)

    FetchAndNavigate id ->
      (model, fetchOne id)

    ShowModal modalName ->
      let
        newModel =
          ({ model | modal = Just modalName })
      in
        (newModel, Cmd.none)
