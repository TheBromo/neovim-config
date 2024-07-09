return {
    -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    dependencies = {
        -- Automatically install LSPs and related tools to stdpath for neovim
        -- Useful status updates for LSP.
        "j-hui/fidget.nvim",
    },

    event = "VeryLazy",

    config = function()
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
            callback = function(event)
                -- In this case, we create a function that lets us more easily define mappings specific
                -- for LSP related items. It sets the mode, buffer and description for us each time.
                local map = function(keys, func, desc)
                    vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                end

                -- Jump to the definition of the word under your cursor.
                --  This is where a variable was first declared, or where a function is defined, etc.
                --  To jump back, press <C-T>.
                map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

                -- Find references for the word under your cursor.
                map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

                -- Jump to the implementation of the word under your cursor.
                --  Useful when your language has ways of declaring types without an actual implementation.
                map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

                -- Jump to the type of the word under your cursor.
                --  Useful when you're not sure what type a variable is and you want to see
                --  the definition of its *type*, not where it was *defined*.
                map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

                -- Fuzzy find all the symbols in your current document.
                --  Symbols are things like variables, functions, types, etc.
                map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

                -- Fuzzy find all the symbols in your current workspace
                --  Similar to document symbols, except searches over your whole project.
                map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

                -- Rename the variable under your cursor
                --  Most Language Servers support renaming across files, etc.
                map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

                -- Execute a code action, usually your cursor needs to be on top of an error
                -- or a suggestion from your LSP for this to activate.
                map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

                -- Opens a popup that displays documentation about the word under your cursor
                --  See `:help K` for why this keymap
                map("K", vim.lsp.buf.hover, "Hover Documentation")

                -- WARN: This is not Goto Definition, this is Goto Declaration.
                --  For example, in C this would take you to the header
                map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

                -- The following two autocommands are used to highlight references of the
                -- word under your cursor when your cursor rests there for a little while.
                --    See `:help CursorHold` for information about when this is executed
                --
                -- When you move your cursor, the highlights will be cleared (the second autocommand).
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                vim.lsp.inlay_hint.enable(true)
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
            end,
        })

        -- LSP servers and clients are able to communicate to each other what features they support.
        --  By default, Neovim doesn't support everything that is in the LSP Specification.
        --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
        --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
        local function configure(server, extra)
            local lspconfig = require("lspconfig")[server]

            local config = {
                capabilities = vim.lsp.protocol.make_client_capabilities(),
            }

            local cmp_status_ok, cmp = pcall(require, "cmp_nvim_lsp")
            if cmp_status_ok then
                config.capabilities = vim.tbl_deep_extend("force", config.capabilities, cmp.default_capabilities())
            end

            if extra then
                config = vim.tbl_deep_extend("force", config, extra)
            end

            lspconfig.setup(config)
            return true
        end

        configure( -- preinstalled
            "nixd",
            {
                settings = {
                    nixd = {
                        formatting = {
                            command = "nixpkgs-fmt",
                        },
                    },
                },
            }
        )
        configure("yamlls", {
            settings = {
                yaml = {
                    schemas = {
                        kubernetes = "*.yaml",
                        ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
                        ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
                        ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
                        ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
                        ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
                        ["http://json.schemastore.org/ansible-playbook"] = "*play*.{yml,yaml}",
                        ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
                        ["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
                        ["https://json.schemastore.org/gitlab-ci"] = "*gitlab-ci*.{yml,yaml}",
                        ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] =
                        "*api*.{yml,yaml}",
                        ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] =
                        "*docker-compose*.{yml,yaml}",
                        ["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] =
                        "*flow*.{yml,yaml}",
                    },
                    format = {
                        enable = true,
                    },
                    hover = true,
                    completion = true,
                },
            },
        })
        configure("gopls", {})
        configure("clangd", {})
        configure("tsserver")
        configure("eslint")
        configure("pyright")

        configure("lua_ls", {
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
                    completion = {
                        callSnippet = "Replace",
                    },
                    -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                    -- diagnostics = { disable = { 'missing-fields' } },
                },
            },
        })
    end,
}
