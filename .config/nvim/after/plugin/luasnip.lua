local ls = require("luasnip")
local cmp = require("cmp")
local snip = ls.snippet
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node


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
    }
})

local function loadTemplate(filename)
    -- Create `insert` at top of template, so that the cursor stays at the start
    local template = { insert(0) }
    local errorMsg = { text("Could not load template: '" .. filename .. "'") }

    local file = io.open(filename, "r")
    if file == nil then return errorMsg end

    -- Insert first line without leading newline
    local line = file:read()
    if line == nil then return errorMsg end
    table.insert(template, text(line))

    while true do
        line = file:read()
        if line == nil then break end
        table.insert(template, text({ "", line }))
    end
    return template
end

local latexTemplatePath = vim.api.nvim_call_function('stdpath', { 'config' }) .. "/after/plugin/snippets/template.tex"


vim.api.nvim_create_autocmd(
    { "Filetype" },
    {
        pattern = { "tex" },
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
                            text({ "", "\t" }), insert(0),
                            text({ "", "\\end{enumerate}" }),
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
                            trig = "block",
                            dscr = "Insert a `\\begin{...} \\end{...}` block"
                        },
                        {
                            text("\\begin{"), insert(1), text("}"),
                            text({ "", "\t" }), insert(2),
                            text({ "", "\\end{" }), func(function(args) return args[1][1] end, { 1 }),
                            text("}")
                        }
                    ),
                    snip(
                        {
                            trig = "template",
                            dscr = "Insert LaTeX template",
                        },
                        loadTemplate(latexTemplatePath)
                    )
                },
            })
        end
    })
