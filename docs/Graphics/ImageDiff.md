## Module Graphics.ImageDiff

#### `IMAGE_MAGICK`

``` purescript
data IMAGE_MAGICK :: !
```

#### `DiffOption`

``` purescript
type DiffOption = { actual :: String, expected :: String, diff :: Maybe String, shadow :: Boolean }
```

`actual` - path to image to test
`expected` - path to expected image
`diff` - path to diff image, if it's `Nothing` it won't be emitted
`shadow` - should unchanged parts be drawn faded                    

#### `diff`

``` purescript
diff :: forall e. DiffOption -> Aff (imageDiff :: IMAGE_MAGICK | e) Boolean
```

calculate diff of images from `DiffOption` and returns 
`true` if they are equal. This `Aff` returns after (maybe) diff
image are written to disk.


