module Update exposing (..)

import Navigation
import Hop exposing (makeUrl, makeUrlFromLocation, setQuery)
import Messages exposing (..)
import Models exposing (..)
import Routing
import Folders.Update


navigationCmd : String -> Cmd a
navigationCmd path =
  Navigation.newUrl (makeUrl Routing.config path)


update : Msg -> MainModel -> (MainModel, Cmd Msg)
update message model =
  case message of
    FoldersMsg subMessage ->
      let
        updateModel =
          { folder = model.folder
          , location = model.location
          , modal = model.modal
          , inputs = model.inputs
          , imgSource = model.imgSource
          }

        (updatedModel, cmd) =
          Folders.Update.update subMessage updateModel
      in
        ({ model
         | folder = updatedModel.folder
         , modal = updatedModel.modal
         , inputs = updatedModel.inputs
         , imgSource = updatedModel.imgSource
         }
        , Cmd.map FoldersMsg cmd)
