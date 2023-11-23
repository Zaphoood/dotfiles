local lsp = require('lsp-zero').preset({})

-- For each buffer, store wether to show diagnostics
ShowDiagnostics = {}
-- For each buffer, store wether to enable formatting
EnableFormatting = {}

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

local function toggleFormatting(bufnr)
    if EnableFormatting[bufnr] == nil or EnableFormatting[bufnr] then
        EnableFormatting[bufnr] = false
        print("Formatting disabled")
    else
        EnableFormatting[bufnr] = true
        print("Formatting enabled")
    end
end


local function endswith(haystack, needle)
    return haystack:sub(- #needle) == needle
end

local disableFormatFiletypes = {
}
local forceNeoformatFiletypes = {
    ".tsx",
    ".ts",
}

lsp.on_attach(function(client, bufnr)
    local formatFn
    local path = vim.api.nvim_buf_get_name(bufnr)
    local forceNeoformat = false
    local disableFormat = false

    for _, filetype in pairs(disableFormatFiletypes) do
        if endswith(path, filetype) then
            disableFormat = true
            break
        end
    end
    for _, filetype in pairs(forceNeoformatFiletypes) do
        if endswith(path, filetype) then
            forceNeoformat = true
            break
        end
    end

    if disableFormat then
        formatFn = function()
        end
    elseif not forceNeoformat and client.supports_method("textDocument/formatting") then
        formatFn = function(event)
            if EnableFormatting[event.buf] == nil or EnableFormatting[event.buf] then
                vim.lsp.buf.format()
            end
        end
    else
        formatFn = function(event)
            if EnableFormatting[event.buf] == nil or EnableFormatting[event.buf] then
                vim.cmd("silent Neoformat")
            end
        end
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
    vim.keymap.set("n", "<leader>tf", function() toggleFormatting(bufnr) end, opts)
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

lsp.on_attach(function()
    local handle = io.popen("pyenv which python")
    if not handle then return end

    local output = handle:read("*a"):gsub("[\n\r]", "")
    handle:close()

    vim.defer_fn(function()
        -- Command may not exists, therefore wrap in `pcall`
        pcall(function() vim.cmd( "PyrightSetPythonPath" .. " " .. output) end)
    end, 1)
end)

lsp.setup()
