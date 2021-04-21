module Tablebot.Plugin.Discord (
    sendMessage, sendMessageVoid, reactToCommand, Message
) where

import Tablebot.Plugin (DatabaseDiscord)

import Discord
import Discord.Types
import qualified Discord.Requests as R
import Data.Text
import Control.Monad.Trans.Class
import Control.Monad (void)

sendMessage :: Message -> Text -> DatabaseDiscord (Either RestCallErrorCode Message)
sendMessage m t = lift . restCall $ R.CreateMessage (messageChannel m) t

sendMessageVoid :: Message -> Text -> DatabaseDiscord ()
sendMessageVoid m t = void $ sendMessage m t

reactToCommand :: Message -> Text -> DatabaseDiscord (Either RestCallErrorCode ())
reactToCommand m e = lift . restCall $ R.CreateReaction (messageChannel m, messageId m) e