-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE
-- Customize Treesitter

---@type LazySpec
return {
  -- Highlight, edit, and navigate code
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup {
      ensure_installed = {
        "c",
        "cpp",
        "lua",
        "python",
        "rust",
        "vimdoc",
        "vim",
        "bash",
        "markdown",
        "markdown_inline",
        "make",
        "cmake",
        "rust",
        "vimdoc",
        "yaml",
        "json",
        "luadoc",
        "query",
        "diff",
        "go",
      },

      modules = {},
      ignore_install = {},
      auto_install = false,
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
    }
  end,
}
