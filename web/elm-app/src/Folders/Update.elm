module Folders.Update exposing (..)

import Folders.Messages exposing (..)
import Folders.Models exposing (Folder)
import Navigation
import Hop exposing (makeUrl)
import Hop.Types exposing (Location)
import Routing
import Folders.Commands exposing (fetchOne, rename, createFolder)
import Models exposing (InputFields)


type alias UpdateModel =
  { folders : List Folder
  , location : Location
  , modal : Maybe String
  , inputs : InputFields
  }


update : Msg -> UpdateModel -> (UpdateModel, Cmd Msg)
update message model =
  case message of
    FetchAllFail error ->
      (model, Cmd.none)

    FetchAllDone newFolders ->
      let
        newModel =
          ({ model | folders = newFolders })
      in
        (newModel, Cmd.none)


    FetchOneFail error ->
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


    FetchAndNavigate id ->
      (model, fetchOne id)


    ShowModal modalName ->
      let
        newModel =
          ({ model | modal = Just modalName })
      in
        (newModel, Cmd.none)

    CloseModal ->
      let
        newModel =
          ({ model | modal = Nothing })
      in
        (newModel, Cmd.none)


    HandleRenameInputChange newName ->
      let
        newInputs =
          { newName = newName
          , newFolder = ""
          }
      in
        ({ model | inputs = newInputs }, Cmd.none)

    RenameFolder folderId ->
      let
        newName =
          model.inputs.newName
      in
        (model, (rename folderId newName))


    RenameFail error ->
      (model, Cmd.none)

    RenameSuccess newFolder ->
      let
        newModel =
          ({ model | folders = [newFolder], modal = Nothing })

        navigateCmd =
          Routing.reverse (Routing.FolderRoute newFolder.id)
            |> makeUrl Routing.config
            |> Navigation.newUrl
      in
        (newModel, navigateCmd)


    HandleNewFolderInputChange newFolder ->
      let
        newInputs =
          { newName = ""
          , newFolder = newFolder
          }
      in
        ({ model | inputs = newInputs }, Cmd.none)

    NewFolder ->
      let
        newFolder =
          model.inputs.newFolder
      in
        (model, (createFolder newFolder))


    NewFolderFail error ->
      (model, Cmd.none)

    NewFolderSuccess newFolder ->
      let
        newModel =
          ({ model | folders = [newFolder], modal = Nothing })

        navigateCmd =
          Routing.reverse (Routing.FolderRoute newFolder.id)
            |> makeUrl Routing.config
            |> Navigation.newUrl
      in
        (newModel, navigateCmd)
