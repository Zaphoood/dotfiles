local pairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")

pairs.get_rules("\"")[1].not_filetypes = { "tex" }
pairs.add_rules({
    Rule("`", "'", "tex"),
})
