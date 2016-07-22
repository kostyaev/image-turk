module Folders.Update exposing (..)

import Folders.Messages exposing (..)
import Folders.Models exposing (Folder)
import Navigation
import Hop exposing (makeUrl)
import Hop.Types exposing (Location)
import Routing
import Folders.Commands exposing (fetchFolder)
import Modals.Commands exposing (renameFolder, createFolder, fetchImages, saveImg)
import Models exposing (InputFields, ModalName, SearchResults, SaveImageResult)


type alias UpdateModel =
  { location : Location
  , folder : Maybe Folder
  , modal : Maybe ModalName
  , inputs : InputFields
  , imgSource : Maybe String
  , searchResults : Maybe SearchResults
  }


update : Msg -> UpdateModel -> (UpdateModel, Cmd Msg)
update message model =
  case message of
    NoOp ->
      (model, Cmd.none)

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
          , query = ""
          }
      in
        ({ model | inputs = newInputs }, Cmd.none)

    RenameFolder folderId ->
      let
        newName =
          model.inputs.newName
      in
        (model, (renameFolder folderId newName))


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
          , query = ""
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


    HandleTurkingInputChange query ->
      let
        newInputs =
          { newName = ""
          , newFolder = ""
          , query = query
          }
      in
        ({ model | inputs = newInputs }, Cmd.none)


    SelectImgSource newSource ->
      let
        newModel =
          ({ model | imgSource = Just newSource})
      in
        (newModel, Cmd.none)


    FetchImages ->
      let
        source =
          case model.imgSource of
            Just source -> source
            Nothing -> "google"

        query =
          model.inputs.query
      in
        (model, fetchImages source query)

    FetchImagesFail error ->
      (model, Cmd.none)

    FetchImagesDone searchResults ->
      let
        newModel =
          ({ model | searchResults = Just searchResults })
      in
        (newModel, Cmd.none)


    SaveImg imgRecord ->
      let
        imgId =
          imgRecord.id

        url =
          imgRecord.url

        folderId =
          case model.folder of
            Just folder -> folder.id
            Nothing -> Debug.crash "Expected folder with an id"
      in
        (model, (saveImg imgId url folderId))

    SaveImgFail error ->
      (model, Cmd.none)

    SaveImgSuccess savedImg ->
      let
        newSearchResults =
          case model.searchResults of
            Just results ->
              ({ results | images =
                List.map
                  (\img ->
                    if img.id == savedImg.id then
                      ({ img | status = Just "saved" })
                    else
                      img
                  )
                  results.images
              })
            Nothing ->
              Debug.crash "Expected not empty search results"

        newModel =
          ({ model | searchResults = Just newSearchResults })
      in
        (newModel, Cmd.none)
