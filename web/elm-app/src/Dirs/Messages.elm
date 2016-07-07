module Dirs.Messages exposing (..)

import Http
import Dirs.Models exposing (DirId, Dir)


type Msg
  = FetchAllDone (List Dir)
  | FetchAllFail Http.Error
  | GoDir DirId
