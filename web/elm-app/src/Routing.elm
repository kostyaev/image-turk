module Routing exposing (..)

import Hop exposing (matcherToPath)
import Hop.Types exposing (Config, PathMatcher)
import Hop.Matchers exposing (..)
import Folders.Models exposing (FolderId)


type Route
  = MainRoute
  | FolderRoute FolderId
  | NotFoundRoute


matchers : List (PathMatcher Route)
matchers =
  [ matcherFolder
  , matcherMain
  ]


matcherFolder : PathMatcher Route
matcherFolder =
  match2 FolderRoute "" int


matcherMain : PathMatcher Route
matcherMain =
  match2 FolderRoute "" int


config : Config Route
config =
  { hash = False
  , basePath = ""
  , matchers = matchers
  , notFound = NotFoundRoute
  }


reverse : Route -> String
reverse route =
  case route of
    MainRoute ->
      matcherToPath matcherMain []

    FolderRoute id ->
      matcherToPath matcherFolder [ toString id ]

    NotFoundRoute ->
      ""
