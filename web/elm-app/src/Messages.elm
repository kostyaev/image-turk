module Messages exposing (..)

import Dirs.Messages

type Msg
  = DirsMsg Dirs.Messages.Msg
  | NoOp
