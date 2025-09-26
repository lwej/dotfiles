---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
  },
  v = {
    [">"] = { ">gv", "indent"},
  },
}

-- more keybinds!
M.xyz = {
  n = {
    ["<leader>tt"] = {
      function()
         require("base46").toggle_theme()
      end,
      "toggle light/dark theme",
    }
  }
}
return M
