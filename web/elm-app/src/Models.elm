module Models exposing (..)

import Folders.Models exposing (Folder)
import Routing
import Hop.Types exposing (Location)


type alias ModalName =
  Maybe String


type alias ImgSource =
  Maybe String


type alias InputFields =
  { newName : String
  , newFolder : String
  , query : String
  }


type alias MainModel =
  { location : Location
  , route : Routing.Route
  , folder : Maybe Folder
  , modal : ModalName
  , inputs: InputFields
  , imgSource : ImgSource
  }


newMainModel : Routing.Route -> Hop.Types.Location -> MainModel
newMainModel route location =
  { location = location
  , route = route
  , folder = Nothing
  , modal = Nothing
  , inputs = InputFields "" "" ""
  , imgSource = Nothing
  }
