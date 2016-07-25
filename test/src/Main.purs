module Test.Main where

import Prelude

import Control.Monad.Aff (launchAff)
import Control.Monad.Aff.Console (CONSOLE, log)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Exception (EXCEPTION, error)
import Control.Monad.Error.Class (throwError)

import Data.Maybe (Maybe(..))

import Graphics.ImageDiff (IMAGE_MAGICK, diff)

pathToActual :: String
pathToActual = "test/images/hello-world.png"

pathToExpected :: String
pathToExpected = "test/images/hello.png"

pathToDiff :: String
pathToDiff = "test/images/hello-diff.png"

output :: String
output = "test/output.png"

main :: Eff (err :: EXCEPTION, imageDiff :: IMAGE_MAGICK, console :: CONSOLE) Unit
main = void $ launchAff do
  helloEqual <-
    diff
      { actual: pathToActual
      , expected: pathToExpected
      , diff: Just output
      , shadow: false
      }
  when helloEqual $ throwError $ error "Images are equal but should not"
  log "Ok, image diff produced"

  diffsEqual <-
    diff
      { actual: output
      , expected: pathToDiff
      , diff: Nothing
      , shadow: false
      }
  when (not diffsEqual) $ throwError $ error "Images are not equal but should be"
  log "Ok, image diff is correct"
