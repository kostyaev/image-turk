module Folders.Models exposing (..)


type alias FolderId =
  Int

type alias ImageRecord =
  { id: Int
  , url: String
  }

type alias SubFolder =
  { id: FolderId
  , name: String
  }


type alias Folder =
  { id: FolderId
  , name: String
  , images: Maybe (List ImageRecord)
  , current: Maybe (List SubFolder)
  , previous: Maybe (List SubFolder)
  }


new : Folder
new =
  { id = 0
  , name = "Untitled folder"
  , images = Just [ImageRecord 0 ""]
  , current = Just [SubFolder 0 ""]
  , previous = Just [SubFolder 0 ""]
  }
