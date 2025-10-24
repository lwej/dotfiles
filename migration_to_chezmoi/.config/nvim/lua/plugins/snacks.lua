return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  opts = {
    picker = {},
    explorer = {
      hidden = true,
    },
  },
  preset = "ivy",
  layout = { position = "bottom" },
  keys = {
    -- { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
    {
      "<leader><space>",
      function()
        Snacks.picker.buffers { layout = {
          preset = "select",
        } }
      end,
      desc = "Buffers",
    },
    -- { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
    { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
    -- { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
    { "<leader>e", function() Snacks.explorer() end, desc = "Toggle File [E]xplorer" },
    -- find
    { "<leader>fb", function() Snacks.picker.buffers() end, desc = "[F]ind [B]uffers" },
    {
      "<leader>fc",
      function() Snacks.picker.files { cwd = vim.fn.stdpath "config" } end,
      desc = "[F]ind [C]onfig File",
    },
    { "<leader>ff", function() Snacks.picker.files() end, desc = "[F]ind [F]iles" },
    -- { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
    { "<leader>fp", function() Snacks.picker.projects() end, desc = "[F]ind [P]rojects" },
    { "<leader>fr", function() Snacks.picker.recent() end, desc = "[F]ind [R]ecent" },
    { "<leader>fw", function() Snacks.picker.grep { layout = "ivy" } end, desc = "[F]ind [Words] (Grep)" },
    -- git
    { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
    { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
    { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
    { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
    { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
    { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
    { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
    -- Grep
    { "<leader>sb", function() Snacks.picker.lines() end, desc = "[S]earch Current [B]uffer" },
    { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "[S]earch Open [B]uffers" },
    {
      "<leader>sw",
      function() Snacks.picker.grep_word() end,
      desc = "[S]earch Selection/ [W]ord",
      mode = { "n", "x" },
    },
    -- search
    { '<leader>s"', function() Snacks.picker.registers() end, desc = "[S]earch Registers" },
    -- { "leader>s/", function() Snacks.picker.search_history() end, desc = "[S]earch History" },
    { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "[S]earch [A]utocmds" },
    { "<leader>sc", function() Snacks.picker.command_history() end, desc = "[S]earch [C]ommand History" },
    { "<leader>sC", function() Snacks.picker.commands() end, desc = "[S]earch [C]ommands" },
    { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "[S]earch [K]eymaps" },
    { "<leader>sp", function() Snacks.picker.lazy() end, desc = "[S]earch for [P]lugin Spec" },
    { "<leader>su", function() Snacks.picker.undo() end, desc = "[S]earch [U]ndo History" },
    -- LSP
    { "gd", function() Snacks.picker.lsp_definitions() end, desc = "[G]oto [D]efinition" },
    { "gR", function() Snacks.picker.lsp_references() end, nowait = true, desc = "[G]oto [R]eferences" },
    { "gD", function() Snacks.picker.lsp_declarations() end, desc = "[G]oto [D]eclaration" },
    -- { "gD", function() Snacks.picker.lsp.buf.declaration() end, desc = "[G]oto [D]eclaration" },
    { "gI", function() Snacks.picker.lsp_implementations() end, desc = "[G]oto [I]mplementation" },
    { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "[G]oto T[y]pe Definition" },
    { "gs", function() Snacks.picker.lsp_document_symbols() end, desc = "[G]oto Document [S]ymbols" },
    { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "L[S]P [S]ymbols" },
    -- { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
    -- Lesser used LSP functionality
    { "<leader>ws", function() Snacks.picker.lsp_dynamic_workspace_symbols() end, desc = "[W]orkspace [S]ymbols" },
    { "<leader>wa", function() Snacks.picker.lsp.buf.add_workspace_folder() end, desc = "[W]orkspace [A]dd Folder" },
    {
      "<leader>wr",
      function() Snacks.picker.lsp.buf.remove_workspace_folder() end,
      desc = "[W]orkspace [R]emove Folder",
    },
    {
      "<leader>wl",
      function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
      desc = "[W]orkspace [L]ist Folders",
    },
    -- Code actions
    { "<leader>ca", function() Snacks.picker.lsp.buf.code_action() end, desc = "[C]ode [A]ction", mode = { "n", "v" } },
    { "<leader>cr", function() Snacks.picker.lsp.buf.rename() end, desc = "[R]ename" },
  },
}
