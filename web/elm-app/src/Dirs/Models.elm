module Dirs.Models exposing (..)


type alias DirId =
  Int

type alias ImageRecord =
  { id: Int
  , url: String
  }

type alias DirRecord =
  { id: Int
  , name: String
  }


type alias Dir =
  { id: DirId
  , name: String
  , images: List ImageRecord
  , current: List DirRecord
  , previous: List DirRecord
  }


new : Dir
new =
  { id = 0
  , name = "Untitled folder"
  , images = [ImageRecord 0 ""]
  , current = [DirRecord 0 ""]
  , previous = [DirRecord 0 ""]
  }
