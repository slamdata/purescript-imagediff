module Graphics.ImageDiff (diff, IMAGE_MAGICK(), DiffOption()) where

import Control.Monad.Aff (Aff())
import Data.Maybe (Maybe(..))
import Data.Function (Fn3(), runFn3)
foreign import data IMAGE_MAGICK :: ! 


-- | `actual` - path to image to test
-- | `expected` - path to expected image
-- | `diff` - path to diff image, if it's `Nothing` it won't be emitted
-- | `shadow` - should unchanged parts be drawn faded                    
type DiffOption =
  { actual :: String
  , expected :: String
  , diff :: Maybe String
  , shadow :: Boolean
  }

foreign import diff_ :: forall a e. Fn3 DiffOption (Maybe a) (a -> Maybe a)
                        (Aff (imageDiff :: IMAGE_MAGICK | e) Boolean)


-- | calculate diff of images from `DiffOption` and returns 
-- | `true` if they are equal. This `Aff` returns after (maybe) diff
-- | image are written to disk.
diff :: forall e. DiffOption -> Aff (imageDiff :: IMAGE_MAGICK|e) Boolean 
diff opts = runFn3 diff_ opts Nothing Just
