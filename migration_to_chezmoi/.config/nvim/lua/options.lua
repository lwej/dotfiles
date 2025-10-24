-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.o` and `:help option-list`

-- === UI ===
vim.o.number = true -- Show absolute line numbers
-- vim.o.relativenumber = true     -- Uncomment to enable relative line numbers
vim.o.signcolumn = "yes" -- Always show signcolumn
vim.o.cursorline = true -- Highlight current line
vim.o.ruler = true -- Show the ruler
vim.opt.colorcolumn = "80,120" -- Highlight columns 80 and 120

-- === Whitespace & Indentation ===
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

-- === Mouse & Clipboard ===
vim.o.mouse = "a" -- Enable mouse support
vim.schedule(function()
  vim.o.clipboard = "unnamedplus" -- Sync clipboard between OS and Neovim
end)

-- === Status & Command Line ===
vim.o.showmode = false -- Don't show mode (handled by statusline)
vim.o.inccommand = "split" -- Live preview of :substitute
vim.o.cmdheight = 0 -- cmdheight of 0 hides command line when not in use

-- === Undo & History ===
vim.o.undofile = true -- Save undo history

-- === Search ===
vim.o.ignorecase = true -- Case-insensitive search...
vim.o.smartcase = true -- ...unless uppercase in search

-- === Splits ===
vim.o.splitright = true -- Vertical splits to the right
vim.o.splitbelow = true -- Horizontal splits below

-- === Performance ===
vim.o.updatetime = 250 -- Faster completion
vim.o.timeoutlen = 300 -- Shorter mapped sequence wait time

-- === Editing ===
vim.o.breakindent = true -- Enable break indent
vim.o.scrolloff = 10 -- Keep lines above/below cursor

-- === Confirmations ===
vim.o.confirm = true -- Prompt to save on quit
