module Main exposing (..)

import Navigation
import Hop exposing (matchUrl)
import Hop.Types exposing (Router)
import Messages exposing (..)
import Models exposing (MainModel, newMainModel)
import View exposing (view)
import Update exposing (update)
import Folders.Commands exposing(fetchRoot)
import Routing


main : Program Never
main =
  Navigation.program urlParser
    { init = init
    , view = view
    , update = update
    , urlUpdate = urlUpdate
    , subscriptions = (always Sub.none)
    }


init : (Routing.Route, Hop.Types.Location) -> (MainModel, Cmd Msg)
init (route, location) =
  (newMainModel route location, Cmd.map FoldersMsg fetchRoot)


urlParser : Navigation.Parser (Routing.Route, Hop.Types.Location)
urlParser =
  Navigation.makeParser (.href >> matchUrl Routing.config)


urlUpdate : (Routing.Route, Hop.Types.Location) -> MainModel -> (MainModel, Cmd Msg)
urlUpdate (route, location) model =
  ({ model | route = route, location = location }, Cmd.none)
