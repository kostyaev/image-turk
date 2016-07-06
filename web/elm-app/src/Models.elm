module Models exposing (..)

import Dirs.Models exposing (Dir)
import Routing


type alias Model =
  { dirs : List Dir
  , route : Routing.Route
  }


initialModel : Routing.Route -> Model
initialModel route =
  { dirs = []
  , route = route
  }
