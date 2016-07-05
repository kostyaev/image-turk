module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model)
import Dirs.Update


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    DirsMsg subMsg ->
      let
        (updatedDirs, cmd) =
          Dirs.Update.update subMsg model.dirs
      in
        ({ model | dirs = updatedDirs }, Cmd.map DirsMsg cmd)

    NoOp ->
      (model, Cmd.none)
