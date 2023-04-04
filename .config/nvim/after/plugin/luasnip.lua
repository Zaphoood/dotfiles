local ls = require("luasnip")
local cmp = require("cmp")
local snip = ls.snippet
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node


cmp.setup({
    sources = {
        {name = 'nvim_lsp'},
        {name = 'luasnip'},
    },
    mapping = {
        ["<Tab>"] = cmp.mapping(function(fallback)
            if ls.expand_or_jumpable() then
                ls.expand_or_jump()
            else
                fallback()
            end
        end, { "i" }),
    }
})


vim.api.nvim_create_autocmd(
{"Filetype"},
{
    pattern = {"tex"},
    callback = function()
        ls.add_snippets(nil, {
            all = {
                snip(
                {
                    trig = "align",
                    dscr = "Insert an `align*` block"
                },
                {
                    text("\\begin{align*}"),
                    text({"", "\t"}), insert(0),
                    text({"", "\\end{align*}"}),
                }
                ),
                snip(
                {
                    trig = "enumerate",
                    dscr = "Insert an `enumerate` block"
                },
                {
                    text("\\begin{enumerate}"),
                    text({"", "\t"}), insert(0),
                    text({"", "\\end{enumerate}"}),
                }
                ),
                snip(
                {
                    trig = "proof",
                    dscr = "Insert a `proof` block"
                },
                {
                    text("\\begin{proof}"),
                    text({"", ""}), insert(0),
                    text({"", "\\end{proof}"}),
                }
                ),
                snip(
                {
                    trig = "block",
                    dscr = "Insert a `\\begin{...} \\end{...}` block"
                },
                {
                    text("\\begin{"), insert(1), text("}"),
                    text({"", "\t"}), insert(2),
                    text({"", "\\end{"}), func(function(args) return args[1][1] end, {1}),
                    text("}")
                }
                ),
            },
        })
    end
})
