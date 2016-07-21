module Models exposing (..)

import Folders.Models exposing (Folder, ImageRecord)
import Routing
import Hop.Types exposing (Location)


type alias ModalName =
  String


type alias ImgSource =
  String


type alias InputFields =
  { newName : String
  , newFolder : String
  , query : String
  }


type alias SearchResults =
  { images: List ImageRecord
  }


type alias MainModel =
  { location : Location
  , route : Routing.Route
  , folder : Maybe Folder
  , modal : Maybe ModalName
  , inputs: InputFields
  , imgSource : Maybe ImgSource
  , searchResults : Maybe SearchResults
  }


newMainModel : Routing.Route -> Hop.Types.Location -> MainModel
newMainModel route location =
  { location = location
  , route = route
  , folder = Nothing
  , modal = Nothing
  , inputs = InputFields "" "" ""
  , imgSource = Nothing
  , searchResults = Nothing
  }
