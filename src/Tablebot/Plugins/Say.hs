-- |
-- Module      : Tablebot.Plugins.Say
-- Description : A very simple example plugin.
-- Copyright   : (c) Finnbar Keating 2021
-- License     : MIT
-- Maintainer  : finnjkeating@gmail.com
-- Stability   : experimental
-- Portability : POSIX
--
-- A command that outputs its input.
module Tablebot.Plugins.Say (sayPlugin) where

import Data.Text (Text, pack)
import Tablebot.Plugin
import Tablebot.Plugin.Discord (Message, sendMessageVoid)
import Tablebot.Plugin.Parser (untilEnd)
import Text.Megaparsec

-- | @say@ outputs its input.
say :: Command
say = Command "say" saycomm
  where
    saycomm :: Parser (Message -> DatabaseDiscord ())
    saycomm = do
      input <- untilEnd <?> ""
      return $ \m -> do
        sendMessageVoid m $ pack $ input ++ " - "

sayHelp :: HelpPage
sayHelp = HelpPage "say" "make the bot speak" "**Say**\nRepeat the input.\n\n*Usage:* `say This text will be repeated by the bot!`" []

-- | @sayPlugin@ assembles the command into a plugin.
sayPlugin :: Plugin
sayPlugin = plug {commands = [say], helpPages = [sayHelp]}
