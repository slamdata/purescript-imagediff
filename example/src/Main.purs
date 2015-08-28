module Main where

import Prelude
import Control.Monad.Aff (runAff)
import Control.Monad.Eff (Eff())
import Control.Monad.Eff.Exception (message, error)
import Control.Monad.Error.Class (throwError)
import Data.Maybe (Maybe(..))
import Graphics.ImageDiff (diff)

import qualified Control.Monad.Eff.Console as C
import qualified Control.Monad.Aff.Console as CA

pathToActual :: String
pathToActual = "example/images/hello-world.png"

pathToExpected :: String
pathToExpected = "example/images/hello.png"

pathToDiff :: String
pathToDiff = "example/images/hello-diff.png"

output :: String
output = "example/output.png"

main = runAff (message >>> C.error) (const $ pure unit) do
  helloEqual <- diff { actual: pathToActual
                     , expected: pathToExpected
                     , diff: Just output
                     , shadow: false
                     }
  if helloEqual
    then throwError $ error "Images are equal but should not"
    else pure unit
  CA.log "Ok, image diff produced"
  diffsEqual <- diff { actual: output
                     , expected: pathToDiff
                     , diff: Nothing
                     , shadow: false
                     }
  if not diffsEqual
    then throwError $ error "Images are not equal but should be"
    else pure unit

  CA.log "Ok, image diff is correct"
