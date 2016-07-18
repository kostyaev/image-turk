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
          { folders = model.folders
          , location = model.location
          , modal = model.modal
          , inputs = model.inputs
          }

        (updatedModel, cmd) =
          Folders.Update.update subMessage updateModel
      in
        ({ model
         | folders = updatedModel.folders
         , modal = updatedModel.modal
         , inputs = updatedModel.inputs
         }
        , Cmd.map FoldersMsg cmd)
