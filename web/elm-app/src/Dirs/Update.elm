module Dirs.Update exposing (..)

import Dirs.Messages exposing (Msg(..))
import Dirs.Models exposing (Dir)


update : Msg -> List Dir -> ( List Dir, Cmd Msg )
update message dirs =
  case message of
    NoOp ->
      ( dirs, Cmd.none )
