local nvim_lsp = require("lspconfig")
local capabilities = require("lsp.capabilities").make()

nvim_lsp.clangd.setup {
  flags = {
    debounce_text_changes = 300,
  },
  capabilities = capabilities,
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--suggest-missing-includes",
    "--completion-style=detailed",
    "-j=28",
    "--offset-encoding=utf-16",
    "--pch-storage=memory",
  }
}
nvim_lsp.intelephense.setup {
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = capabilities,
  settings = {
    intelephense = {
      environment = {
        includePaths = { "/home/andi/engine/tornado/src", }
      },
      files = {
        maxSize = 5000000;
      },
    }
  }
}
nvim_lsp.pylsp.setup {
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = capabilities,
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          maxLineLength = 200,
        },
        flake8 = {
          maxLineLength = 200,
        }
      }
    }
  }
}
nvim_lsp.taplo.setup {
  flags = {},
  capabilities = capabilities,
  settings = {}
}
nvim_lsp.vimls.setup {
  flags = {},
  capabilities = capabilities,
  settings = {}
}
nvim_lsp.lua_ls.setup {
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    }
  }
}

--[[ FIXME: didn't required due to rustaceanvim
nvim_lsp.rust_analyzer.setup {

  on_attach = function(client, bufnr)
    vim.lsp.inlay_hint.enable(bufnr)
  end,
  flags = {
    debounce_text_changes = 0,
  },
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = {
        command = "clippy"
      },
      imports = {
        granularity = {
          group = "module",
        },
        prefix = "self",
      },
      cargo = {
        buildScripts = {
          enable = true,
        },
      },
      procMacro = {
        enable = true
      },
    }
  }
}
]]--
nvim_lsp.typos_lsp.setup({
  config = {
    cmd_env = { RUST_LOG = "error" }
  },
  init_options = {
    config = "~/.config/nvim/typos.toml",
    diagnosticSeverity = "Information"
  }
})
