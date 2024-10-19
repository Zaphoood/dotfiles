local ls = require("luasnip")
local cmp = require("cmp")
local snip = ls.snippet
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node

local snippetsDefined = false


cmp.setup({
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
    mapping = {
        ["<Tab>"] = cmp.mapping(function(fallback)
            if ls.expand_or_jumpable() then
                ls.expand_or_jump()
            else
                fallback()
            end
        end, { "i" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if ls.jumpable(-1) then
                ls.jump(-1)
            else
                fallback()
            end
        end, { "i" }),
    }
})

local function valueOfNthInsert(n)
    return func(function(args) return args[1][1] end, { n })
end

vim.api.nvim_create_autocmd(
    { "Filetype" },
    {
        pattern = { "tex" },
        callback = function()
            -- There is a correct way to add these snippets without an autocmd and without using
            -- this snippetsDefined flag, but I haven't figured it out

            if snippetsDefined then return end
            snippetsDefined = true

            ls.add_snippets(nil, {
                all = {
                    snip(
                        {
                            trig = "align",
                            dscr = "Insert an `align*` block"
                        },
                        {
                            text("\\begin{align*}"),
                            text({ "", "\t" }), insert(0),
                            text({ "", "\\end{align*}" }),
                        }
                    ),
                    snip(
                        {
                            trig = "enumerate",
                            dscr = "Insert an `enumerate` block"
                        },
                        {
                            text("\\begin{enumerate}"),
                            text({ "", "\t\\item " }), insert(0),
                            text({ "", "\\end{enumerate}" }),
                        }
                    ),
                    snip(
                        {
                            trig = "itemize",
                            dscr = "Insert an `itemize` block"
                        },
                        {
                            text("\\begin{itemize}"),
                            text({ "", "\t\\item " }), insert(0),
                            text({ "", "\\end{itemize}" }),
                        }
                    ),
                    snip(
                        {
                            trig = "proof",
                            dscr = "Insert a `proof` block"
                        },
                        {
                            text("\\begin{proof}"),
                            text({ "", "" }), insert(0),
                            text({ "", "\\end{proof}" }),
                        }
                    ),
                    snip(
                        {
                            trig = "beg",
                            dscr = "Insert a `\\begin{...} \\end{...}` block"
                        },
                        {
                            text("\\begin{"), insert(1), text("}"),
                            text({ "", "\t" }), insert(2),
                            text({ "", "\\end{" }), valueOfNthInsert(1),
                            text("}")
                        }
                    ),
                    snip(
                        {
                            trig = "fr",
                            dscr = "Fraction"
                        },
                        {
                            text("\\frac{"),
                            insert(1), text("}{"),
                            insert(2), text("}"),
                        }
                    ),
                    snip(
                        {
                            trig = "ys",
                            dscr = "List of items with ellipsis in between"
                        },
                        {
                            insert(1),
                            text("_"),
                            insert(2),
                            text(", \\ldots, "),
                            valueOfNthInsert(1),
                            text("_"),
                            insert(3),
                        }
                    ),
                },
            })
        end
    })

ls.add_snippets(nil, {
    all = {
        snip(
            {
                trig = "ifnm",
                dscr = "Create the usual `if __name__ == \"__main__\": ...`"
            },
            {
                text("def main():"),
                text({ "", "    " }), insert(0),
                text({ "", "" }),
                text({ "", "if __name__ == \"__main__\":" }),
                text({ "", "    main()" }),
            }
        ),
    },
})
