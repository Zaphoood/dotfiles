vim.g.mapleader = ","
vim.g.maplocalleader = ","

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "<leader>ws", function() vim.cmd("set list!") end)

vim.keymap.set("i", "<C-A>", "<Home>", { noremap = true } )
vim.keymap.set("i", "<C-E>", "<End>", { noremap = true } )
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

vim.api.nvim_create_autocmd(
{"Filetype"},
{
    pattern = {"tex"},
    callback = function()
        vim.keymap.set("n", "<leader>bl", "o\\begin{align*}\n\n\\end{align*}kA	")
        vim.keymap.set("n", "<leader>be", "o\\begin{enumerate*}\n\n\\end{enumerate*}kA	")
        vim.keymap.set("n", "<leader>bp", "o\\begin{proof}\n\n<BS>\\end{proof}kA")
        vim.keymap.set("i", "<C-]>", "\\{  \\}hhi")
    end
})
