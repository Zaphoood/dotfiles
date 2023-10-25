vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "<leader>ws", function() vim.cmd("set list!") end)

vim.keymap.set("i", "<C-A>", "<Home>", { noremap = true })
vim.keymap.set("i", "<C-E>", "<End>", { noremap = true })

vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("n", "<leader>n", ":cnext<Enter>zz")
vim.keymap.set("n", "<leader>N", ":cprev<Enter>zz")
vim.keymap.set("n", "<leader><Tab>", ":tabnew<Enter>")


vim.api.nvim_create_autocmd(
    { "Filetype" },
    {
        pattern = { "tex" },
        callback = function()
            vim.keymap.set("i", "<C-]>", "\\{  \\}hhi")
        end
    })

vim.api.nvim_create_autocmd(
    { "Filetype" },
    {
        pattern = { "markdown" },
        callback = function()
            vim.cmd("iab \"a ä")
            vim.cmd("iab \"o ö")
            vim.cmd("iab \"u ü")
            vim.cmd("iab \"A Ä")
            vim.cmd("iab \"O Ö")
            vim.cmd("iab \"U Ü")
        end
    })
