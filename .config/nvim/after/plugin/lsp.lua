local lsp = require('lsp-zero').preset({})

-- Table {bufnr: int, showDiagnostics: bool}
ShowDiagnostics = {}

local function toggleDiagnostics(bufnr)
    if ShowDiagnostics[bufnr] == nil then
        ShowDiagnostics[bufnr] = true
    end

    if ShowDiagnostics[bufnr] then
        ShowDiagnostics[bufnr] = false
        vim.diagnostic.disable(bufnr)
        print("Diagnostics disabled")
    else
        ShowDiagnostics[bufnr] = true
        vim.diagnostic.enable(bufnr)
        print("Diagnostics enabled")
    end
end

lsp.on_attach(function(client, bufnr)
    local formatFn
    if client.supports_method("textDocument/formatting") then
        formatFn = function() vim.lsp.buf.format() end
    else
        formatFn = function() vim.cmd("Neoformat") end
    end
    vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = formatFn
    })

    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>qf", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "]g", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "[g", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>td", function() toggleDiagnostics(bufnr) end, opts)
end)

require('lspconfig').lua_ls.setup {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' },
            },
        },
    },
}

lsp.setup()
