local wk = require("which-key")

wk.setup({
  plugins = {
    spelling = { enabled = true },
  },
  win = {
    border = "rounded",
  },
  triggers = {},
})

wk.add({
  { "<leader>?", "<cmd>WhichKey<CR>", desc = "Which-key" },
  { "<leader>c", desc = "Toggle Codex" },
  { "<leader>d", group = "diagnostics" },
  { "<leader>dl", desc = "List diagnostics" },
  { "<leader>f", group = "find" },
  { "<leader>fa", desc = "Live grep" },
  { "<leader>fb", desc = "Buffers" },
  { "<leader>fc", desc = "Buffer fuzzy find" },
  { "<leader>ff", desc = "Find files" },
  { "<leader>fh", desc = "Search history" },
  { "<leader>fm", desc = "Marks" },
  { "<leader>fs", desc = "Document symbols" },
  { "<leader>n", desc = "Neo-tree toggle" },
  { "<leader>t", desc = "Toggleterm" },
  { "<leader>v", desc = "Claude Code" },
  { "<leader>w", group = "whitespace" },
  { "<leader>wc", "<cmd>StripWhitespaceOnChangedLines<CR>", desc = "Strip on changed lines" },
  { "<leader>wd", "<cmd>DisableWhitespace<CR>", desc = "Disable highlights" },
  { "<leader>we", "<cmd>EnableWhitespace<CR>", desc = "Enable highlights" },
  { "<leader>ws", "<cmd>StripWhitespace<CR>", desc = "Strip whitespace" },
  { "<leader>wt", "<cmd>ToggleWhitespace<CR>", desc = "Toggle highlights" },
})

wk.add({
  { "g", group = "goto" },
  { "ga", desc = "Neo-tree buffers" },
  { "gd", desc = "Definition" },
  { "gD", desc = "Declaration" },
  { "gi", desc = "Implementation" },
  { "gr", desc = "References" },
  { "<C-c>", desc = "Pick buffer" },
  { "<C-h>", desc = "Prev buffer" },
  { "<C-l>", desc = "Next buffer" },
  { "<C-q>", desc = "Close buffer" },
  { "<C-x>", desc = "Force close buffer" },
  { "<C-t>", desc = "Neo-tree reveal" },
  { ",<space>", desc = "Clear search highlight" },
  { "/", group = "hop" },
  { "/a", desc = "Hint anywhere" },
  { "/s", desc = "Hint char1" },
  { "/f", desc = "Hint patterns" },
  { "//", desc = "Native search" },
  { "<C-z>", desc = "Suspend (job control)" },
}, { mode = "n" })
