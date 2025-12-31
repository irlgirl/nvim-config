require("mason").setup()

vim.o.completeopt = "menuone,noselect"
vim.lsp.set_log_level("ERROR")

vim.diagnostic.config {
  signs = true,
  underline = true,
  virtual_text = false,
  virtual_lines = false,
  update_in_insert = false,
  severity_sort = true,
  float = {
    header = false,
    border = "rounded",
    focusable = true,
  }
}

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local builtin = require("telescope.builtin")
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    local opts = { buffer = ev.buf, silent = true }

    vim.keymap.set("n", "gd", builtin.lsp_definitions, opts)
    vim.keymap.set("n", "gi", builtin.lsp_implementations, opts)
    vim.keymap.set("n", "gr", builtin.lsp_references, opts)

    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "K", function()
      if vim.bo.filetype == "rust" then
        vim.cmd.RustLsp({ "hover", "actions" })
      else
        vim.lsp.buf.hover()
      end
    end, opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)

--    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
--    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
--    vim.keymap.set('n', '<space>wl', function()
--      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--    end, opts)
    vim.keymap.set("n", "<space>D", builtin.lsp_type_definitions, opts)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)

    vim.keymap.set({ "n", "v" }, "<space>ca", function()
      if vim.bo.filetype == "rust" then
        vim.cmd.RustLsp("codeAction")
      else
        vim.lsp.buf.code_action()
      end
    end, opts)

    vim.keymap.set("v", "ff", vim.lsp.buf.format, opts)
    vim.keymap.set("n", "ff", function()
      vim.lsp.buf.format { async = false }
    end, opts)

    if client and client.supports_method("textDocument/documentHighlight") then
      local hl_group = vim.api.nvim_create_augroup("LspDocumentHighlight" .. ev.buf, { clear = true })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        group = hl_group,
        buffer = ev.buf,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        group = hl_group,
        buffer = ev.buf,
        callback = vim.lsp.buf.clear_references,
      })
    end
  end,
})
