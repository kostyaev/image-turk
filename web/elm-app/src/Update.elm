module Update exposing (..)

import Debug
import Navigation
import Hop exposing (makeUrl, makeUrlFromLocation, setQuery)
import Hop.Types
import Messages exposing (..)
import Models exposing (..)
import Routing
import Folders.Update
import Folders.Models


navigationCmd : String -> Cmd a
navigationCmd path =
  Navigation.newUrl (makeUrl Routing.config path)


routerConfig : Hop.Types.Config Route
routerConfig =
  Routing.config


update : Msg -> MainModel -> (MainModel, Cmd Msg)
update message model =
  case Debug.log "message" message of
    FoldersMsg subMessage ->
      let
        updateModel =
          { folders = model.folders
          , location = model.location
          }

        (updatedModel, cmd) =
          Folders.Update.update subMessage updateModel
      in
        ({ model | folders = updatedModel.folders }, Cmd.map FoldersMsg cmd)

    SetQuery query ->
      let
        command =
          model.location
            |> setQuery query
            |> makeUrlFromLocation routerConfig
            |> Navigation.newUrl
      in
        (model, command)
