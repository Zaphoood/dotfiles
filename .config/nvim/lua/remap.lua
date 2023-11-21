vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- [t]oggle [w]hitespace
vim.keymap.set("n", "<leader>tw", function() vim.cmd("set list!") end)

-- Emacs-like shortcuts while in insert mode
vim.keymap.set("i", "<C-A>", "<Home>", { noremap = true })
vim.keymap.set("i", "<C-E>", "<End>", { noremap = true })

vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

-- [n]ext compilation error
vim.keymap.set("n", "<leader>n", ":cnext<Enter>zz")
vim.keymap.set("n", "<leader>N", ":cprev<Enter>zz")
vim.keymap.set("n", "<leader><Tab>", ":tabnew<Enter>")

-- [f]old
vim.keymap.set("n", "<leader>f", "za")

-- [w]rap in **bold**
local function make_wrap(before, after)
    local function wrap()
        -- `vim.fn.line` and `vim.fn.col` both use 1-based indexing
        local start_row = vim.fn.line("v") - 1
        local start_col = vim.fn.col("v") - 1
        local end_row = vim.fn.line(".") - 1
        local end_col = vim.fn.col(".") - 1

        local swapped = start_row > end_row or (start_row == end_row and start_col > end_col)
        if swapped then
            -- Swap if cursor is at start of visual selection
            start_row, end_row = end_row, start_row
            start_col, end_col = end_col, start_col
        end

        -- We want to insert _after_ end of visual mode
        end_col = end_col + 1

        local same_line = end_row == start_row
        if same_line then
            -- If on same line, end column will be shifted by what we insert at the start
            end_col = end_col + before:len()
        end

        vim.api.nvim_buf_set_text(0, start_row, start_col, start_row, start_col, { before })
        vim.api.nvim_buf_set_text(0, end_row, end_col, end_row, end_col, { after })

        if swapped then
            -- This is a shitty workaround but nvim doesn't let me move the other end of the selection programmatically
            local to_move
            if same_line then
                to_move = before:len() + after:len()
            else
                to_move = after:len()
            end

            vim.api.nvim_feedkeys("o", "m", false)
            vim.api.nvim_feedkeys(tostring(to_move) .. "l", "m", false)
            vim.api.nvim_feedkeys("o", "m", false)
        else
            -- `nvim_win_set_cursor` uses (1, 0)-based indexing
            vim.api.nvim_win_set_cursor(0, { end_row + 1, end_col + after:len() - 1 })
        end
    end

    return wrap
end

-- format is `{key, left, right}`, where `key` is the key to trigger the wrapper
local wrappers = {
    { "(",  "(",  ")" },
    { "[",  "[",  "]" },
    { "{",  "{",  "}" },
    { "<",  "<",  ">" },
    { "\"", "\"", "\"" },
    { "'",  "'",  "'" },
    { "`",  "`",  "`" },
    { "_",  "_",  "_" },
    { "$",  "$",  "$" },
    { "*",  "**", "**" },
}

for _, pair in pairs(wrappers) do
    local key, left, right = unpack(pair)
    vim.keymap.set({ "v" }, "<leader>w" .. key, make_wrap(left, right))
end

-- common typo
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
