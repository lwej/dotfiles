-- Based on kickstart.nvim
-- https://github.com/nvim-lua/kickstart.nvim

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({ import = "plugins" }, {
  change_detection = {
    notify = false,
  },
})

require "options"
require "keymap"
require "commands"

function DoFileIfExists(file_path)
  if vim.fn.filereadable(file_path) == 0 then
    vim.notify("Could not run dofile on '" .. file_path .. "'")
    return false
  end

  local ok, res = pcall(dofile, file_path)
  if not ok then vim.notify("Could not run file:\n" .. res) end
  return ok
end

-- vim: ts=2 sts=2 sw=2 et

require "custom.theme"
