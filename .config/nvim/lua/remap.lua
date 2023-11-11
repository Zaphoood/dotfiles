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

vim.keymap.set("n", "<leader>f", "za")

vim.cmd("iab symporg symprog")
vim.cmd("iab SymPorg SymProg")

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
            vim.cmd("iab ss ß")
            vim.cmd("iab SS ẞ")

            vim.cmd("iab 'a á")
            vim.cmd("iab 'e é")
            vim.cmd("iab 'i í")
            vim.cmd("iab 'o ó")
            vim.cmd("iab 'u ú")
            vim.cmd("iab 'A Á")
            vim.cmd("iab 'E É")
            vim.cmd("iab 'I Í")
            vim.cmd("iab 'O Ó")
            vim.cmd("iab 'U Ú")
        end
    })
