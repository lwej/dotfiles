return {
  "theprimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function() require("harpoon"):setup() end,
  keys = {
    { "<leader>A", function() require("harpoon"):list():add() end, desc = "harpoon file" },
    {
      "<leader>a",
      function()
        local harpoon = require "harpoon"
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = "harpoon quick menu",
    },
    -- lazy 42 keys, instead of using number layer
    { "<leader>hq", function() require("harpoon"):list():select(1) end, desc = "harpoon to file 1" },
    { "<leader>hw", function() require("harpoon"):list():select(2) end, desc = "harpoon to file 2" },
    { "<leader>he", function() require("harpoon"):list():select(3) end, desc = "harpoon to file 3" },
    { "<leader>hr", function() require("harpoon"):list():select(4) end, desc = "harpoon to file 4" },
    { "<leader>ht", function() require("harpoon"):list():select(5) end, desc = "harpoon to file 5" },
    -- defaults
    -- { "<leader>1", function() require("harpoon"):list():select(1) end, desc = "harpoon to file 1", },
    -- { "<leader>2", function() require("harpoon"):list():select(2) end, desc = "harpoon to file 2", },
    -- { "<leader>3", function() require("harpoon"):list():select(3) end, desc = "harpoon to file 3", },
    -- { "<leader>4", function() require("harpoon"):list():select(4) end, desc = "harpoon to file 4", },
    -- { "<leader>5", function() require("harpoon"):list():select(5) end, desc = "harpoon to file 5", },
  },
}
