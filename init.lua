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

  use 'tklepzig/vim-buffer-navigator'
  use 'schickling/vim-bufonly'
  use 'easymotion/vim-easymotion'
  use 'rbgrouleff/bclose.vim'

  use 'preservim/nerdtree'

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
  use "williamboman/nvim-lsp-installer"
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
-- Plug 'nvim-lua/lsp-status.nvim'

  -- LSP Modules
  use 'rust-lang/rust.vim'
  use 'tekumara/typos-lsp'

  -- color schemas
  use 'morhetz/gruvbox'  -- colorscheme gruvbox
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

  use 'stevearc/profile.nvim'
end)


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

vim.g.gitgutter_enabled = false

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>gm', builtin.marks, {})
vim.keymap.set('n', '<leader>gr', builtin.lsp_references, {})
vim.keymap.set('n', '<leader>gd', builtin.diagnostics, {})

vim.g.BufferNavigatorMapKeys = 0
vim.keymap.set('n', 'ga', '<cmd>:BufferNavigatorToggle<CR>')
vim.g.BufferNavigatorHighlightRules = {
    {"CppFile", "file", ".*\\.cpp", "NONE", "cyan", "NONE", "cyan"},
    {"RustFile", "file", ".*\\.rs", "NONE", "cyan", "NONE", "cyan"},
    {"TomlFile", "file", ".*\\.toml", "NONE", "blue", "NONE", "red"},
    {"CppHeader", "file", ".*\\.h", "NONE", "green", "NONE", "green"},
    {"TLFile", "file", ".*\\.tl", "NONE", "cyan", "NONE", "cyan"},
    {"Txt", "file", ".*\\.txt", "NONE", "white", "NONE", "white"},
    {"LogTxt", "file", ".*\\.log", "NONE", "white", "NONE", "white"},
    {"CommonDirectory", "dir", "common", "NONE", "yellow", "NONE", "yellow"},
    {"SrcDirectory", "dir", "src", "NONE", "yellow", "NONE", "yellow"},
    }
vim.keymap.set('n', '<C-k>', '<cmd>:bn<CR>')
vim.keymap.set('n', '<C-j>', '<cmd>:bp<CR>')
vim.keymap.set('n', 'gw', '<cmd>:Bclose<CR>')
vim.keymap.set('n', 'gon', '<cmd>:BOnly<CR>')

-- easymotion
vim.g.EasyMotion_smartcase = 1
vim.keymap.set('n', ',<space>', '<cmd>:nohlsearch<CR>') -- turn off search highlight
--vim.keymap.set('n', '<Leader>', '<Plug>(easymotion-prefix)')
vim.keymap.set('n', 's', '<Plug>(easymotion-overwin-f)')
vim.keymap.set('n', '/', '<Plug>(easymotion-sn)')
vim.keymap.set('o', '/', '<Plug>(easymotion-tn)')
-- These `n` & `N` mappings are options. You do not have to map `n` & `N` to EasyMotion.
-- Without these mappings, `n` & `N` works fine. (These mappings just provide
-- different highlight method and have some other features )
vim.keymap.set('n', 'n', '<Plug>(easymotion-next)')
vim.keymap.set('n', 'N', '<Plug>(easymotion-prev)')

-- nnoremap <C-t> :NERDTreeFocus<CR>
vim.keymap.set('n', '<C-t>', '<cmd>:NERDTreeToggle<CR>')

vim.g.workspace_autocreate = 0

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

vim.o.termguicolors = false
vim.cmd[[colorscheme gruvbox]]
require('nvim-web-devicons').setup {
   default = true;
}
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme  = 'gruvbox',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {},
    lualine_x = {'location', 'encoding'},
    lualine_y = {
      {
        'buffers',
        max_length = vim.o.columns * 2 / 3,
        show_filename_only = true,   -- Shows shortened relative path when set to false.

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
