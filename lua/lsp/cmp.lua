require("cmp_nvim_lsp")
require("cmp_nvim_lua")

local luasnip = require("luasnip")
local cmp = require("cmp")

local select_opts = { behavior = cmp.SelectBehavior.Select }

cmp.setup {
  completion = {
    autocomplete = false
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping.select_prev_item(select_opts),
    ["<C-n>"] = cmp.mapping.select_next_item(select_opts),
    --["<C-d>"] = cmp.mapping.scroll_docs(-4),
    --["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-b>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
  }),
  view = { docs = { auto_open = true } },
  sources = {
    { name = "nvim_lsp" },
    { name = "nvim_lsp_signature_help" },
    { name = "path", keyword_length },
--    { name = 'buffer', keyword_length = 3 },
--    { name = 'luasnip', keyword_length = 3 },
  },
  window = {
    documentation = cmp.config.window.bordered(),
    completion = cmp.config.window.bordered(),
  },
  formatting = {
    fields = { "menu", "abbr", "kind" },
    format = function(entry, item)
      local menu_icon = {
        nvim_lsp = "λ",
        -- buffer = "Ω",
        path = "∫",
        -- luasnip = "†",
      }

      item.menu = menu_icon[entry.source.name]
      return item
    end,
  },
}
