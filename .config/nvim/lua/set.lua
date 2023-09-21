-- UI
vim.opt.nu = true
vim.opt.rnu = true
vim.opt.listchars = "eol:$,space:.,tab:>-"
vim.opt.ruler = true
vim.opt.scrolloff = 2
vim.opt.smartindent = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true
vim.opt.mouse = ""
vim.opt.updatetime = 50

-- Split
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Tab
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true

vim.api.nvim_create_autocmd(
    { "Filetype" },
    {
        pattern = { "c,cpp,html,css,javascript,typescript,markdown" },
        callback = function()
            vim.opt.softtabstop = 2
            vim.opt.shiftwidth = 2
            vim.opt.tabstop = 2
        end
    })

vim.api.nvim_create_autocmd(
    { "Filetype" },
    {
        pattern = { "go" },
        callback = function()
            vim.opt.expandtab = false
        end
    })

vim.api.nvim_create_autocmd(
    { "Filetype" },
    {
        pattern = { "asm" },
        callback = function()
            vim.opt.expandtab = false
            vim.opt.softtabstop = 8
            vim.opt.shiftwidth = 8
            vim.opt.tabstop = 8
        end
    })

-- Spell check
vim.api.nvim_create_autocmd(
    { "Filetype" },
    {
        pattern = { "tex" },
        callback = function()
            vim.opt_local.spell = true
            -- Assume German for .tex files
            vim.opt_local.spelllang = "de_de"
        end
    })
