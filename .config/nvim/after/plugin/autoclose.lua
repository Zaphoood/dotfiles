require("autoclose").setup({
    keys = {
        ["$"] = {
            close = true,
            escape = true,
            pair = "$$",
            enabled_filetypes = { "tex" },
        },
        ["\\{"] = {
            close = true,
            pair = "\\{\\}",
            enabled_filetypes = { "tex" },
        },
        ["\""] = {
            close = true,
            escape = true,
            pair = "\"\"",
            disabled_filetypes = { "tex", "markdown" }
        },
        ["'"] = {
            close = true,
            escape = true,
            pair = "''",
            disabled_filetypes = { "tex", "markdown" }
        },
        ["`"] = {
            close = true,
            escape = true,
            pair = "``",
            disabled_filetypes = { "tex" }
        },
    }
})
