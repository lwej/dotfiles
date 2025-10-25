---@type NvPluginSpec[]
local plugins = {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
      vim.keymap.set('v', "<leader>fm",
        function ()
          vim.lsp.buf.format {
            async = true,
            range = {
              ["start"] = vim.api.nvim_buf_get_mark(0, "<"),
              ["end"] = vim.api.nvim_buf_get_mark(0, ">"),
            }
          }
          vim.api.nvim_input "<Esc>"
        end,
        {desc = "format selection"})
    end
  },
  {
    "tpope/vim-surround",
    lazy = false,
  },
  {
    "natecraddock/workspaces.nvim",
    lazy = false,
    config = function ()
      print("Loading workspaces")
      require('workspaces').setup({
        path = vim.fn.stdpath("data") .. "/workspaces",
        auto_open = true,
      })
    end
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    -- ft = "python",
    lazy = false,
    config = function ()
      local null_ls = require('null-ls')
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.clang_format,
          null_ls.builtins.diagnostics.shellcheck,
          null_ls.builtins.diagnostics.cpplint,
        }
      })
    end
  },
  {
    "ntpeters/vim-better-whitespace",
    lazy = false,
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
          layout_strategy = "vertical",
          layout_config = {
              height = 0.95,
              prompt_position = "top",
              vertical = {
                  mirror = true,
                  preview_cutoff = 0,
              },
          },
      },
    },
  },
  {
    "sainnhe/everforest",
    lazy = false,
  },
}
return plugins
