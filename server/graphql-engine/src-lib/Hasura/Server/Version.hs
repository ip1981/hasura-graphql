module Hasura.Server.Version
  ( currentVersion
  ) where

import Data.Version (showVersion)

import qualified Data.Text as T

import Hasura.Prelude

import Paths_graphql_engine (version)

currentVersion :: T.Text
currentVersion = T.pack . showVersion $ version
