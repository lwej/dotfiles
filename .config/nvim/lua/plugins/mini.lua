return {
  {
    "nvim-mini/mini.nvim",
    config = function()
      require("mini.ai").setup { n_lines = 500 }
      require("mini.surround").setup()
    end,
  },
  -- { "nvim-mini/mini.icons", event = "VeryLazy" },
}
