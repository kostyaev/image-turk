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
  , children: Maybe (List SubFolder)
  , siblings: Maybe (List SubFolder)
  , parent: Maybe FolderId
  }


new : Folder
new =
  { id = 0
  , name = "Untitled folder"
  , images = Just [ImageRecord 0 ""]
  , children = Just [SubFolder 0 ""]
  , siblings = Just [SubFolder 0 ""]
  , parent = Nothing
  }
