return {
    specs = {
        { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
        "https://github.com/nvim-treesitter/nvim-treesitter-context",
    },
    setup = function()
        require("nvim-treesitter").setup({
            install_dir = vim.fn.stdpath("data") .. "/site",
        })

        local parsers = {
            "terraform", "hcl", "yaml", "go", "tsx", "bash", "c", "diff", "html", "lua", "luadoc", "markdown",
            "markdown_inline",
            "query", "vim", "vimdoc",
        }
        require("nvim-treesitter").install(parsers)

        vim.api.nvim_create_autocmd("FileType", {
            callback = function(args)
                local buf, filetype = args.buf, args.match

                local language = vim.treesitter.language.get_lang(filetype)
                if not language then return end

                if not vim.treesitter.language.add(language) then return end
                vim.treesitter.start(buf, language)

                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })

        require("treesitter-context").setup({
            enable = true,
            max_lines = 4,
            separator = "─",
        })
    end,
}
