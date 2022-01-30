module NvFetcher.Utils where

import Data.Binary
import qualified Data.ByteString as BS
import qualified Data.ByteString.Lazy as LBS
import Data.Text (Text)
import qualified Data.Text as T
import Development.Shake
import Text.Regex.TDFA ((=~))

encode' :: Binary a => a -> BS.ByteString
encode' = BS.concat . LBS.toChunks . encode

decode' :: Binary a => BS.ByteString -> a
decode' = decode . LBS.fromChunks . pure

quote :: Text -> Text
quote = T.pack . show

getShakeDir :: Action FilePath
getShakeDir = shakeFiles <$> getShakeOptions

isLegalNixId :: Text -> Bool
isLegalNixId x = x =~ "^[a-zA-Z_][a-zA-Z0-9_'-]*$"

quoteIfNeeds :: Text -> Text
quoteIfNeeds x
  | isLegalNixId x = x
  | otherwise = quote x
