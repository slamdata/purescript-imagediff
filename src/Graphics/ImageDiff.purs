module Graphics.ImageDiff
  ( IMAGE_MAGICK
  , DiffOptions
  , diff
  ) where

import Control.Monad.Aff (Aff)
import Data.Maybe (Maybe, isJust, fromJust)
import Partial.Unsafe (unsafePartial)

foreign import data IMAGE_MAGICK :: !

-- | `actual` - path to image to test
-- | `expected` - path to expected image
-- | `diff` - path to diff image, if it's `Nothing` it won't be emitted
-- | `shadow` - should unchanged parts be drawn faded
type DiffOptions =
  { actual :: String
  , expected :: String
  , diff :: Maybe String
  , shadow :: Boolean
  }

foreign import diff_
  :: forall eff
   . (forall a. Maybe a -> Boolean)
  -> (forall a. Maybe a -> a)
  -> DiffOptions
  -> Aff (imageDiff :: IMAGE_MAGICK | eff) Boolean

-- | Calculate diff of images from `DiffOption` and returns `true` if they are
-- | equal. This `Aff` returns after (maybe) diff image are written to disk.
diff :: forall eff. DiffOptions -> Aff (imageDiff :: IMAGE_MAGICK | eff) Boolean
diff = diff_ isJust (unsafePartial fromJust)
