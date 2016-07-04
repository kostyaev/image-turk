module Dirs.Models exposing (..)


type alias DirId =
  Int


type alias ImgsList =
  List String


type alias Dir =
  { id : DirId
  , name : String
  , images : ImgsList
  }


new : Dir
new =
  { id = 0
  , name = ""
  , images = [""]
  }
