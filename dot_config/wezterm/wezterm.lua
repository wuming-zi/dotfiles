local wezterm = require("wezterm")
local Config = require("config")

local cfg = Config:init():append(require("config.key")):append(require("config.ui"))

cfg.options.enable_kitty_keyboard = true

return cfg.options
