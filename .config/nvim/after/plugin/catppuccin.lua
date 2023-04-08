TransparentBackground = true

local catppuccin = require("catppuccin")

catppuccin.setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    transparent_background = TransparentBackground,
})

vim.cmd.colorscheme("catppuccin")

vim.keymap.set("n", "<leader>tt", function()
    if TransparentBackground then
        TransparentBackground = false
    else
        TransparentBackground = true
    end
    catppuccin.setup({
        transparent_background = TransparentBackground,
    })
    vim.cmd.colorscheme("catppuccin")
end)
