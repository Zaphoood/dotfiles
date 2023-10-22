require("autoclose").setup({
    keys = {
        ["$"] = {
            close = true,
            escape = true,
            pair = "$$",
            enabled_filetypes = { "tex" },
        },
        ["\""] = {
            disabled_filetypes = { "tex" }
        }
    }
})
