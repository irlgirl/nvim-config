-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', { command = 'source <afile> | PackerCompile', group = packer_group, pattern = 'init.lua' })

require('packer').startup(function(use)
 -- use 'wbthomason/packer.nvim' -- Package manager
 -- use 'tpope/vim-fugitive' -- Git commands in nvim
 -- use 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github
 -- use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines
 -- use 'ludovicchabant/vim-gutentags' -- Automatic tags management
  -- UI to select things (files, grep results, open buffers...)
 -- use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
 -- use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
 -- use 'mjlbach/onedark.nvim' -- Theme inspired by Atom
 -- use 'nvim-lualine/lualine.nvim' -- Fancier statusline
  -- Add indentation guides even on blank lines
 -- use 'lukas-reineke/indent-blankline.nvim'
  -- Add git related info in the signs columns and popups
 -- use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  -- Highlight, edit, and navigate code using a fast incremental parsing library
 -- use 'nvim-treesitter/nvim-treesitter'
  -- Additional textobjects for treesitter
 -- use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'wbthomason/packer.nvim'

  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin,
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip' -- Snippets plugin

  use {
    'smoka7/hop.nvim',
    tag = '*', -- optional but strongly recommended
  }
  use 'schickling/vim-bufonly'
  use 'rbgrouleff/bclose.vim'

  use {
    "nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
      }
  }

  use {
    "folke/noice.nvim",
    requires = {
      "rcarriga/nvim-notify",
    }
  }

  use({
    "utilyre/barbecue.nvim",
    tag = "*",
    requires = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    after = "nvim-web-devicons", -- keep this if you're using NvChad
    config = function()
      require("barbecue").setup()
    end,
  })

  use {'junegunn/fzf', run = ":call fzf#install()"}
  use 'junegunn/fzf.vim'
  use 'airblade/vim-gitgutter'

  use 'nvim-treesitter/nvim-treesitter'
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
  -- or                            , branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use 'ntpeters/vim-better-whitespace'

  -- LSP server
  use "williamboman/nvim-lsp-installer" -- TODO: replace by MASON
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
-- Plug 'nvim-lua/lsp-status.nvim'

  -- LSP Modules
  use 'rust-lang/rust.vim'
  use 'tekumara/typos-lsp'

  -- TODO: try SLSPSAGA

  -- color schemas
  use 'morhetz/gruvbox'  -- colorscheme gruvbox
  use 'folke/tokyonight.nvim'
  use 'bluz71/vim-nightfly-colors'

  -- use 'octol/vim-cpp-enhanced-highlight'
--Plug 'mhartington/oceanic-next'  " colorscheme OceanicNext
--Plug 'kaicataldo/material.vim', { 'branch': 'main' }
--Plug 'ayu-theme/ayu-vim'

  use 'thaerkh/vim-workspace'

--Plug 'rmagatti/goto-preview'

  require "cmp_nvim_lsp"
  require "cmp_nvim_lua"
  require 'lspconfig'

  require("nvim-lsp-installer").setup {
    automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
  }

  -- statusline
  use 'kyazdani42/nvim-web-devicons'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  use 'lewis6991/gitsigns.nvim' -- OPTIONAL: for git status
  use 'romgrk/barbar.nvim'

  use 'stevearc/profile.nvim'
end)


-- Core Settings
vim.o.mouse = "a"
vim.o.encoding = "utf-8"
vim.o.number = true
vim.o.swapfile = false
vim.o.scrolloff = 7

vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.fileformat = unix
--TODO: vim.o.indent = "on"    -- load filetype-specific indent files
--
vim.keymap.set('t', '<ESC>', '<C-\\><C-n>')
-- Core Settings END


-- Disable GitGutter; TODO: replace to another git-plugin
vim.g.gitgutter_enabled = false
-- Disable GitGutter END


-- Setup devicons (requires by many plugings)
require('nvim-web-devicons').setup {
   default = true;
}
-- Setup devicons END


-- Setup noice (cmd + notifications UI)
require("noice").setup({
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
})
-- Setup noice END


-- Setup telescope (fzf-like search plugin
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', 'gs', builtin.live_grep, {})
vim.keymap.set('n', '<leader>ga', builtin.buffers, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>gm', builtin.marks, {})
vim.keymap.set('n', '<leader>gr', builtin.lsp_references, {})
vim.keymap.set('n', '<leader>gd', builtin.diagnostics, {})
require("telescope").load_extension("noice")
-- Setup telescope END


-- Setup barbar (a tab-bar in top)
require'barbar'.setup {
 -- Excludes buffers from the tabline TODO
  exclude_ft = {'javascript'},
  exclude_name = {'package.json'},
  tabpages = true,
}
vim.keymap.set('n', '<C-c>', '<Cmd>BufferPick<CR>')
vim.keymap.set('n', '<C-l>', '<Cmd>BufferNext<CR>')
vim.keymap.set('n', '<C-h>', '<Cmd>BufferPrevious<CR>')
vim.keymap.set('n', '<C-q>', '<Cmd>BufferClose<CR>')
-- Setup barbar END


-- Setup Hop (easymotion-like plugin)
local hop = require('hop')
hop.setup{
  jump_on_sole_occurrence = false,
  case_insensitive = true,
  create_hl_autocmd = true,
}
local directions = require('hop.hint').HintDirection

vim.keymap.set('', '/a', function()
  hop.hint_anywhere()
end, {remap=true})

vim.keymap.set('n', '/s', function()
  hop.hint_char1()
end, {remap=true})

vim.keymap.set('n', '/f', function()
  hop.hint_patterns()
end, {remap=true})

vim.keymap.set('n', '//', ':/')

vim.keymap.set('n', ',<space>', '<cmd>:nohlsearch<CR>') -- turn off search highlight
-- Setup easymotion END

-- Setup neo-tree (file tree + buffer-tree)
require("neo-tree").setup({
  enable_diagnostics = false,
  enable_git_status = false,
  window = {
    mappings = {
      ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
    }
  },
  event_handlers = {
    {
      event = "file_opened",
      handler = function(file_path)
        require("neo-tree.command").execute({ action = "close" })
      end
    },
  }
})
vim.keymap.set('n', '<C-t>', '<cmd>:Neotree toggle position=float <CR>')
vim.keymap.set('n', 'ga', '<cmd>:Neotree buffers toggle position=float <CR>')
-- Setup neo-tree END


-- Setup workspace plugin
vim.g.workspace_autocreate = 0
vim.g.workspace_create_new_tabs = 0
vim.g.workspace_session_directory = os.getenv( "HOME" ) .. "/.config/nvim/sessions/"
vim.g.workspace_undodir = os.getenv( "HOME" ) .. '/.config/nvim/sessions/.undodir'

vim.g.workspace_session_disable_on_args = 1
-- Setup workspace plugin END


-- Setup nvim-profile plugin
local should_profile = os.getenv("NVIM_PROFILE")
if should_profile then
  require("profile").instrument_autocmds()
  if should_profile:lower():match("^start") then
    require("profile").start("*")
  else
    require("profile").instrument("*")
  end
end

local function toggle_profile()
  local prof = require("profile")
  if prof.is_recording() then
    prof.stop()
    vim.ui.input({ prompt = "Save profile to:", completion = "file", default = "profile.json" }, function(filename)
      if filename then
        prof.export(filename)
        vim.notify(string.format("Wrote %s", filename))
      end
    end)
  else
    prof.start("*")
  end
end
vim.keymap.set("", "<f1>", toggle_profile)
-- Setup nvim-profile END


-- Setup colour theme
vim.o.termguicolors = false
vim.cmd[[colorscheme nightfly]]
vim.g.nightflyNormalFloat = true
-- Setup colour theme END

-- Setup lualine (line in bottom)
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme  = auto,
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {
      {
        'searchcount',
        maxcount = 999,
        timeout = 500,
      }
    },
    lualine_x = {'location', 'encoding'},
    lualine_y = {
      {
        'filetype',
        colored = true,
        icon_only = true,
      },
      {
        'filename',
        path = 1,
      }
    },
    lualine_z = {"os.date('%X')"}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},

    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
-- Setup lualine END


-- Setup code-complete-plugin + LSP
require "cmp_nvim_lsp"
require "cmp_nvim_lua"

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

vim.lsp.set_log_level("ERROR")
local nvim_lsp = require('lspconfig')

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-s>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('v', 'ff', '<ESC><cmd> lua vim.lsp.buf.format()<CR>', opts)
    vim.keymap.set('n', 'ff', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

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
    "-j=8",
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
        includePaths = { '/home/andi/engine/tornado/src', }
      },
      files = {
        maxSize = 5000000;
      },
    }
  }
};
nvim_lsp.pyright.setup {
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = capabilities,
  settings = {
  }
}
nvim_lsp.taplo.setup {
  flags = {
  },
  capabilities = capabilities,
  settings = {
  }
}
nvim_lsp.vimls.setup {
  flags = {
  },
  capabilities = capabilities,
  settings = {
  }
}
nvim_lsp.rust_analyzer.setup {
  flags = {
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
nvim_lsp.typos_lsp.setup({
    config = {
        -- Logging level of the language server. Logs appear in :LspLog. Defaults to error.
        cmd_env = { RUST_LOG = "error" }
    },
    init_options = {
        -- Custom config. Used together with any workspace config files, taking precedence for
        -- settings declared in both. Equivalent to the typos `--config` cli argument.
        config = '~/code/typos-lsp/crates/typos-lsp/tests/typos.toml',
        -- How typos are rendered in the editor, eg: as errors, warnings, information, or hints.
        -- Defaults to error.
        diagnosticSeverity = "Information"
    }
})

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'

local select_opts = {behavior = cmp.SelectBehavior.Select}

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
    ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
    ['<C-n>'] = cmp.mapping.select_next_item(select_opts),
    --['<C-d>'] = cmp.mapping.scroll_docs(-4),
    --['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-b>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'path', keyword_length },
--    { name = 'buffer', keyword_length = 3 },
    { name = 'luasnip', keyword_length = 3 },
  },
  window = {
    documentation = cmp.config.window.bordered()
  },
  formatting = {
    fields = {'menu', 'abbr', 'kind'},
    format = function(entry, item)
      local menu_icon = {
        nvim_lsp = 'λ',
        buffer = 'Ω',
        path = '∫',
        luasnip = '†',
      }

      item.menu = menu_icon[entry.source.name]
      return item
    end,
  },
}

vim.diagnostic.config({severity_sort = true })
