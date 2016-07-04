module Models exposing (..)

import Dirs.Models exposing (Dir)


type alias Model =
  { dirs : List Dir
  }


initialModel : Model
initialModel =
  { dirs = [ Dir 1 "pizza" [""] ]
  }
