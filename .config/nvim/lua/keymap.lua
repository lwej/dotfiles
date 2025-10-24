-- [[ Basic Keymaps ]] See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- DANGER, after restoring a session some buffers are hidden, all the stuff!
vim.keymap.set("n", "<leader>be", ":bufdo e<CR>", { desc = 'Edit "load" all buffers' })

vim.keymap.set("n", "<Tab>", ":bnext<CR>", { desc = "Go to next buffer in the list" })
vim.keymap.set("n", "<S-Tab>", ":bprev<CR>", { desc = "Go to previous buffer in the list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -4<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +4<CR>", { desc = "Increase window width" })

-- wrappers

local wrap_pairs = {
  ["["] = { "[", "]" },
  ["{"] = { "{", "}" },
  ["("] = { "(", ")" },
  ["<"] = { "<", ">" },
  ["'"] = { "'", "'" },
  ['"'] = { '"', '"' },
}

for key, pair in pairs(wrap_pairs) do
  vim.keymap.set("v", "<leader>" .. key, function()
    local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
    vim.cmd("normal! c" .. pair[1] .. vim.fn.getreg "v" .. pair[2] .. esc .. "P")
  end, { desc = "Wrap selection with " .. pair[1] .. pair[2] })
end

-- which-key
vim.keymap.set("n", "<leader>c", "<nop>", { desc = "Code" })
vim.keymap.set("n", "<leader>f", "<nop>", { desc = "Find" })
vim.keymap.set("n", "<leader>s", "<nop>", { desc = "Search" })
vim.keymap.set("n", "<leader>g", "<nop>", { desc = "Git" })
vim.keymap.set("n", "<leader>h", "<nop>", { desc = "Harpoon" })
vim.keymap.set("n", "<leader>w", "<nop>", { desc = "Workspace" })
vim.keymap.set("n", "<leader>ö", "<nop>", { desc = "Custom" })
