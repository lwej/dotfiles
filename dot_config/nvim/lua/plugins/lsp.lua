local function switch_source_header_splitcmd(bufnr, splitcmd)
    local method_name = "textDocument/switchSourceHeader"
    local client = vim.lsp.get_clients({ bufnr = bufnr, name = "clangd" })[1]
    if not client then
        return vim.notify(("method %s is not supported by any servers active on the current buffer"):format(method_name))
    end

    local params = vim.lsp.util.make_text_document_params(bufnr)
    client.request(method_name, params, function(err, result)
        if err then error(tostring(err)) end
        if not result then
            vim.notify "corresponding file cannot be determined"
            return
        end
        vim.api.nvim_command(splitcmd .. " " .. vim.uri_to_fname(result))
    end, bufnr)
end

return {
    {
        -- LSP Configuration & Plugins
        "mason-org/mason.nvim",
        dependencies = {
            "saghen/blink.cmp",
            "neovim/nvim-lspconfig",
            "mason-org/mason-lspconfig.nvim",
            "nvim-tree/nvim-web-devicons",
            { "j-hui/fidget.nvim", opts = {} },
        },
        lazy = false,
        config = function()
            -- Default enable/disable inlay hints
            vim.g.inlay_hints_enabled = true

            --  This function gets run when an LSP connects to a particular buffer.
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
                callback = function(event)
                    local nmap = function(keys, func, desc)
                        if desc then desc = "LSP: " .. desc end
                        vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
                    end

                    nmap("<leader>öe", function() switch_source_header_splitcmd(0, "edit") end,
                        "Edit source/header in new tab")
                    nmap("<leader>öh", function() switch_source_header_splitcmd(0, "split") end,
                        "Edit source/header in hsplit")
                    nmap("<leader>öv", function() switch_source_header_splitcmd(0, "vsplit") end,
                        "Edit source/header in vsplit")

                    -- See `:help K` for why this keymap
                    nmap("K", vim.lsp.buf.hover, "Hover Documentation")

                    -- The following two autocommands are used to highlight references of the
                    -- word under your cursor when your cursor rests there for a little while.
                    --    See `:help CursorHold` for information about when this is executed
                    --
                    -- When you move your cursor, the highlights will be cleared (the second autocommand).
                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if client and client.server_capabilities.documentHighlightProvider then
                        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                            buffer = event.buf,
                            callback = vim.lsp.buf.document_highlight,
                        })

                        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                            buffer = event.buf,
                            callback = vim.lsp.buf.clear_references,
                        })
                    end
                    if client and client.server_capabilities.inlayHintProvider then
                        local toggle_inlay_hint = function()
                            vim.g.inlay_hints_enabled = not vim.g.inlay_hints_enabled
                            vim.lsp.inlay_hint.enable(vim.g.inlay_hints_enabled)
                        end

                        if vim.g.inlay_hints_enabled == true then vim.lsp.inlay_hint.enable(true) end
                        nmap("<leader>th", toggle_inlay_hint, "Toggle Inlay Hints")
                    end
                end,
            })

            -- LSP log level
            vim.lsp.log.set_level(vim.log.levels.WARN)

            vim.diagnostic.config {
                severity_sort = true,
                float = { border = "single", source = "if_many" },
                virtual_text = true,
            }

            local servers = {
                clangd = {
                    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
                    capabilities = {
                        offsetEncoding = { "utf-16" },
                    },
                    -- Skip cretaing clangd utility user commands
                    on_attach = function(_, _) end,
                },
                gopls = {},
                basedpyright = {},
                rust_analyzer = {},
                -- tsserver = {},
                -- html = { filetypes = { 'html', 'twig', 'hbs'} },

                lua_ls = {
                    settings = {
                        Lua = {
                            runtime = { version = "LuaJIT" },
                            workspace = {
                                checkThirdParty = false,
                                -- Tells lua_ls where to find all the Lua files that you have loaded
                                -- for your neovim configuration.
                                library = {
                                    "${3rd}/luv/library",
                                    unpack(vim.api.nvim_get_runtime_file("", true)),
                                },
                                -- If lua_ls is really slow on your computer, you can try this instead:
                                -- library = { vim.env.VIMRUNTIME },
                            },
                            telemetry = { enable = false },
                            diagnostics = {
                                globals = { "vim" },
                                -- diagnostics = { disable = { 'missing-fields' } },
                            },
                        },
                    },
                },
            }

            -- try loading local lsp server settings. Table should be in same format as above
            local local_lsp = require("custom.helpers").tryRequire "local.lsp_settings"
            -- print("local_lsp loaded:", local_lsp ~= nil)
            -- if local_lsp ~= nil then
            --     print("local_lsp.lsp_servers:", vim.inspect(local_lsp.lsp_servers))
            -- end
            if local_lsp ~= nil and local_lsp.lsp_servers ~= nil then
                print("Merging local lsp server settings")
                servers = vim.tbl_deep_extend("force", servers, local_lsp.lsp_servers)
            --     print("Merged servers:", vim.inspect(servers))
            end
            require("mason").setup()
            require("mason-lspconfig").setup {
                automatic_enable = true,
                ensure_installed = vim.tbl_keys(servers),
            }

            for server_name, config in pairs(servers) do
                config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
                vim.lsp.config(server_name, config)
            end

            -- Add blink capabilities to all LSPs not explicitly configured
            vim.lsp.config("*", {
                capabilities = require("blink.cmp").get_lsp_capabilities(),
            })
        end,
    },
}
