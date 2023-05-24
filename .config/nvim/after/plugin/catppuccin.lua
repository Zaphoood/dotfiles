TransparentBackground = true

local catppuccin = require("catppuccin")

catppuccin.setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    transparent_background = TransparentBackground,
})

vim.cmd.colorscheme("catppuccin")

vim.keymap.set("n", "<leader>tt", function()
    if TransparentBackground then
        print("Transparent background off")
        TransparentBackground = false
    else
        print("Transparent background on")
        TransparentBackground = true
    end
    catppuccin.setup({
        transparent_background = TransparentBackground,
    })
    vim.cmd.colorscheme("catppuccin")
end)
