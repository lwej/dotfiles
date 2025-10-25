return {
  "coffebar/neovim-project",
  opts = {
    projects = {
      "~/projects/*",
    },
    picker = {
      type = "snacks", -- one of "telescope", "fzf-lua", or "snacks"
    },
    -- Dashboard mode prevent session autoload on startup
    dashboard_mode = true,
  },
  config = function(_, opts)
    local tryRequire = require("custom.helpers").tryRequire
    local local_project = tryRequire "local.project_settings"
    if local_project and local_project.projects then vim.list_extend(opts.projects, local_project.projects) end
    require("neovim-project").setup(opts)
  end,
  init = function()
    -- enable saving the state of plugins in the session
    vim.opt.sessionoptions:append "globals" -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
  end,
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    -- optional picker
    -- { "nvim-telescope/telescope.nvim", tag = "0.1.4" },
    -- optional picker
    -- { "ibhagwan/fzf-lua" },
    -- optional picker
    { "folke/snacks.nvim" },
    { "Shatur/neovim-session-manager" },
  },
  lazy = false,
  priority = 100,
}
