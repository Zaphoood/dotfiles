vim.opt.nu = true
vim.opt.listchars = "eol:$,space:.,tab:>-"
vim.opt.ruler = true
vim.opt.scrolloff=2

vim.opt.smartindent = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true

vim.api.nvim_create_autocmd(
{"Filetype"},
{
    pattern = {"c,cpp,html,css,javascript,typescript,markdown"},
    callback = function()
        vim.opt.softtabstop = 2
        vim.opt.shiftwidth = 2
        vim.opt.tabstop = 2
    end
})

vim.api.nvim_create_autocmd(
{"Filetype"},
{
    pattern = {"go"},
    callback = function()
        vim.opt.expandtab = false
    end
})
