module Dirs.Models exposing (..)


type alias DirId =
  Int

type alias ImageRecord =
  { id: Int
  , url: String
  }

type alias SubDir =
  { id: DirId
  , name: String
  }


type alias Dir =
  { id: DirId
  , name: String
  , images: Maybe (List ImageRecord)
  , current: Maybe (List SubDir)
  , previous: Maybe (List SubDir)
  }


new : Dir
new =
  { id = 0
  , name = "Untitled folder"
  , images = Just [ImageRecord 0 ""]
  , current = Just [SubDir 0 ""]
  , previous = Just [SubDir 0 ""]
  }
