module Routing exposing (..)

import Hop exposing (matcherToPath)
import Hop.Types exposing (Config, PathMatcher)
import Hop.Matchers exposing (..)
import Folders.Models exposing (FolderId)


type Route
  = MainRoute
  | FolderRoute FolderId
  | NotFoundRoute


config : Config Route
config =
  { hash = False
  , basePath = ""
  , matchers = matchers
  , notFound = NotFoundRoute
  }


matchers : List (PathMatcher Route)
matchers =
  [ matchFolder
  , matchMain
  ]


matchFolder : PathMatcher Route
matchFolder =
  match2 FolderRoute "/" int


matchMain : PathMatcher Route
matchMain =
  match1 MainRoute ""


reverse : Route -> String
reverse route =
  case route of
    MainRoute ->
      matcherToPath matchMain []

    FolderRoute id ->
      matcherToPath matchFolder [ toString id ]

    NotFoundRoute ->
      ""
