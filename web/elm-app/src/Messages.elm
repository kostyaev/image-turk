module Messages exposing (..)

import Folders.Messages


type Msg
  = FoldersMsg Folders.Messages.Msg
