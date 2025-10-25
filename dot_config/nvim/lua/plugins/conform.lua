return {
  "stevearc/conform.nvim",

  dependencies = { "williamboman/mason.nvim" },
  lazy = true,
  cmd = "ConformInfo",
  keys = {
    {
      "<leader>cf",
      function() require("conform").format { timeout_ms = 3000 } end,
      mode = { "n", "v" },
      desc = "Code Format",
    },
    {
      "<leader>bf",
      function() vim.cmd 'bufdo lua require("conform").format()' end,
      mode = { "n" },
      desc = "Format all buffers",
    },
  },
  opts = function()
    local opts = {
      default_format_opts = {
        timeout_ms = 3000,
        async = false, -- not recommended to change
        quiet = false, -- not recommended to change
        lsp_format = "fallback", -- not recommended to change
      },
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        sh = { "shfmt" },
      },
      formatters = {
        injected = { options = { ignore_errors = true } },
      },
    }
    return opts
  end,
}
