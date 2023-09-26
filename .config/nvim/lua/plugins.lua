return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.1",
        dependencies = { { "nvim-lua/plenary.nvim" } }
    },
    { "catppuccin/nvim",                 as = "catppuccin" },
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    { "lervag/vimtex" },
    { "tpope/vim-fugitive" },
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v2.x",
        dependencies = {
            -- LSP Support
            { "neovim/nvim-lspconfig" },
            {
                "williamboman/mason.nvim",
                build = function()
                    pcall(vim.cmd, "MasonUpdate")
                end,
            },
            { "williamboman/mason-lspconfig.nvim" },
            -- Autocompletion
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-nvim-lsp" },
            { 'L3MON4D3/LuaSnip' },
        }
    },
    { "sbdchd/neoformat" },
    { "L3MON4D3/LuaSnip" },
    { "saadparwaiz1/cmp_luasnip" },
}
