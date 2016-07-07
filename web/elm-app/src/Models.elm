module Models exposing (..)

import Folders.Models exposing (Folder)
import Routing
import Hop.Types exposing (Location)


type alias MainModel =
  { location : Location
  , route : Routing.Route
  , folders: List Folder
  }


newMainModel : Route -> Hop.Types.Location -> MainModel
newMainModel route location =
  { location = location
  , route = route
  , folders = []
  }
