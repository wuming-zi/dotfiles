local wezterm = require("wezterm")

local Config = {}
Config.__index = Config

function Config:init()
  local config = setmetatable({ options = {} }, self)
  return config
end

function Config:append(new_options)
  for k, v in pairs(new_options) do
    if self.options[k] ~= nil then
      wezterm.log_warn("The item has been set")
      goto continue
    end
    self.options[k] = v
    ::continue::
  end
  return self
end

return Config
