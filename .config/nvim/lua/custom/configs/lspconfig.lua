local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local lspconfig = require "lspconfig"

local function switch_source_header_splitcmd(bufnr, splitcmd)
  bufnr = lspconfig.util.validate_bufnr(bufnr)
  local clangd_client = lspconfig.util.get_active_client_by_name(bufnr, 'clangd')
  local params = {uri = vim.uri_from_bufnr(bufnr)}
  if clangd_client then
    clangd_client.request("textDocument/switchSourceHeader", params, function(err, result)
      if err then
        error(tostring(err))
      end
      if not result then
        print("Corresponding file can’t be determined")
        return
      end
      vim.api.nvim_command(splitcmd .. " " .. vim.uri_to_fname(result))
    end, bufnr)
  else
    print 'textDocument/switchSourceHeader is not supported by the clangd server active on the current buffer'
  end
end

local function file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

lspconfig.clangd.setup({
  capabilities = capabilities,
  cmd = {
    "clangd",
    "-j=8",
    "--clang-tidy",
    "--clang-tidy-checks=*",
  },
  on_attach = function (client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
    vim.keymap.set('n', "<leader>]e", function() switch_source_header_splitcmd(0, 'edit') end, { noremap = true, desc = "Edit source/header in new tab"})
    vim.keymap.set('n', "<leader>]h", function() switch_source_header_splitcmd(0, 'split') end, { noremap = true, desc = "Edit source/header in hsplit"})
    vim.keymap.set('n', "<leader>]v", function() switch_source_header_splitcmd(0, 'vsplit') end, { noremap = true, desc = "Edit source/header in vsplit"})
    vim.keymap.set('n', "<f5>", function() if file_exists("./run.sh") then require("nvterm.terminal").send("clear; ./run.sh", "horizontal") end end, { noremap = true, desc = "Run ./run.sh"})
    on_attach(client, bufnr)
  end,
})

lspconfig.pyright.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig.cmake.setup{}
