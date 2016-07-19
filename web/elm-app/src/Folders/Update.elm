module Folders.Update exposing (..)

import Folders.Messages exposing (..)
import Folders.Models exposing (Folder)
import Navigation
import Hop exposing (makeUrl)
import Hop.Types exposing (Location)
import Routing
import Folders.Commands exposing (fetchFolder, rename, createFolder)
import Models exposing (InputFields, ModalName)


type alias UpdateModel =
  { location : Location
  , folder : Maybe Folder
  , modal : Maybe ModalName
  , inputs : InputFields
  }


update : Msg -> UpdateModel -> (UpdateModel, Cmd Msg)
update message model =
  case message of
    FetchRootFail error ->
      (model, Cmd.none)

    FetchRootDone newFolder ->
      let
        newModel =
          ({ model | folder = Just newFolder })
      in
        (newModel, Cmd.none)


    FetchFolderFail error ->
      (model, Cmd.none)

    FetchFolderDone newFolder ->
      let
        newModel =
          ({ model | folder = Just newFolder })

        navigateCmd =
          Routing.reverse (Routing.FolderRoute newFolder.id)
            |> makeUrl Routing.config
            |> Navigation.newUrl
      in
        (newModel, navigateCmd)


    FetchAndNavigate id ->
      (model, fetchFolder id)


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
          ({ model | folder = Just newFolder, modal = Nothing })

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
        folderName =
          model.inputs.newFolder

        parent =
          case model.folder of
            Just folder -> folder.id
            Nothing -> Debug.crash "Maybe you have an error"
      in
        (model, (createFolder folderName parent))


    NewFolderFail error ->
      (model, Cmd.none)

    NewFolderSuccess newFolder ->
      let
        newModel =
          ({ model | folder = Just newFolder, modal = Nothing })

        navigateCmd =
          Routing.reverse (Routing.FolderRoute newFolder.id)
            |> makeUrl Routing.config
            |> Navigation.newUrl
      in
        (newModel, navigateCmd)
