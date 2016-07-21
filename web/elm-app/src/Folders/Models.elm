module Folders.Models exposing (..)


type alias FolderId =
  String


type alias FolderName =
  String


type alias ModalName =
  String


type alias ImageRecord =
  { id: String
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
  , parent: FolderId
  }


new : Folder
new =
  { id = ""
  , name = "Untitled folder"
  , images = Just [ImageRecord "" ""]
  , children = Just [SubFolder "" ""]
  , siblings = Just [SubFolder "" ""]
  , parent = ""
  }
