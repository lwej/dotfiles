---@type ChadrcConfig
local M = {}

local highlights = require "custom.highlights"

M.ui = {
    theme = 'everforest',
    theme_toggle = {'everforest', 'everforest_light'},
    statusline = {
      theme = "minimal",
      separator_style = "block",
    },
    hl_override = highlights.override,
    hl_add = highlights.add,
}
M.mappings = require 'custom.mappings'

M.plugins = 'custom.plugins'
return M
