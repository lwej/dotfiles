-- Choose theme depending on darkman result
local function detect_theme()
  if vim.fn.executable "darkman" == 1 then
    local handle = io.popen "darkman get"
    if handle then
      local result = handle:read "*a"
      handle:close()
      return (result and result:gsub("%s+", "")) or "dark"
    else
      vim.notify("Failed to run darkman, defaulting to dark theme", vim.log.levels.WARN)
      return "dark"
    end
  else
    vim.notify("darkman not found, defaulting to dark theme", vim.log.levels.INFO)
    return "dark"
  end
end

local mode = detect_theme()
vim.g.catppuccin_flavour = (mode == "light") and "latte" or "macchiato"
vim.cmd.colorscheme "catppuccin"
