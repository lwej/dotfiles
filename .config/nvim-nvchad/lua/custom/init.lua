vim.api.nvim_create_autocmd("FileType", {
   pattern = "*",
   command = "setlocal shiftwidth=4 tabstop=4 colorcolumn=120"
})
