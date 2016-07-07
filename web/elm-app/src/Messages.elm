module Messages exposing (..)

import Hop.Types exposing (Query)
import Folders.Messages


type Msg
  = SetQuery Query
  | FoldersMsg Folders.Messages.Msg
