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
 -- use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  -- Add indentation guides even on blank lines
 -- use 'lukas-reineke/indent-blankline.nvim'
  -- Add git related info in the signs columns and popups
 -- use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use 'wbthomason/packer.nvim'

  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin,
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip' -- Snippets plugin

  -- smt for async
  use {
    'nvim-lua/plenary.nvim'
  }

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

  use { "rcarriga/nvim-notify", }
  use {
    "folke/noice.nvim",
    requires = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
      "nvim-treesitter/nvim-treesitter",
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
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
  -- or                            , branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use 'ntpeters/vim-better-whitespace'

  -- LSP server
  use "williamboman/mason.nvim"

  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
-- Plug 'nvim-lua/lsp-status.nvim'

  -- LSP Modules
  use 'tekumara/typos-lsp'
  use 'rust-lang/rust.vim'

  use {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    ft = { 'rust' },
  }

  -- TODO: try SLSPSAGA
  --
  use 'mfussenegger/nvim-dap' -- TODO: Debugging!!!

  -- color schemas
  use 'ellisonleao/gruvbox.nvim'
  use 'folke/tokyonight.nvim'
  use 'bluz71/vim-nightfly-colors'
  use { "catppuccin/nvim", as = "catppuccin" }
  use {'AlexvZyl/nordic.nvim'}
  use "EdenEast/nightfox.nvim"

  -- use 'octol/vim-cpp-enhanced-highlight'
--Plug 'mhartington/oceanic-next'  " colorscheme OceanicNext
--Plug 'kaicataldo/material.vim', { 'branch': 'main' }
--Plug 'ayu-theme/ayu-vim'

  use 'thaerkh/vim-workspace'

--Plug 'rmagatti/goto-preview'

  require "cmp_nvim_lsp"
  require "cmp_nvim_lua"
  require 'lspconfig'

  require("mason").setup()

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

vim.keymap.set('n', 'TT', '<cmd>:terminal<CR>')
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
--
-- Setup telescope (fzf-like search plugin)

require('telescope').setup{
  pickers = {
    lsp_references = {
      initial_mode="normal"
    },
    diagnostics = {
      initial_mode="normal"
    },
  },
  defaults = { file_ignore_patterns = {"vendor"} }
}
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fa', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fm', builtin.marks, {})
vim.keymap.set('n', '<leader>fh', builtin.search_history, {})
vim.keymap.set('n', '<leader>fc', builtin.current_buffer_fuzzy_find, {})

vim.keymap.set('n', '<leader>dl', builtin.diagnostics, {})
require("telescope").load_extension("noice")
require("telescope").load_extension("notify")

-- Setup telescope END


-- Setup barbar (a tab-bar in top)
require'barbar'.setup {
 -- Excludes buffers from the tabline TODO
  -- exclude_ft = {'javascipt'},
  -- exclude_name = {'package.json'},
  tabpages = true,
  animation = true,
  hide = { extensions = false, inactive = false },


}
vim.keymap.set('n', '<C-c>', '<Cmd>BufferPick<CR>')
vim.keymap.set('n', '<C-l>', '<Cmd>BufferNext<CR>')
vim.keymap.set('n', '<C-h>', '<Cmd>BufferPrevious<CR>')
vim.keymap.set('n', '<C-q>', '<Cmd>BufferClose<CR>')
vim.keymap.set('n', '<C-x>', '<Cmd>BufferClose!<CR>')
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

vim.keymap.set('n', '//', '/')

vim.keymap.set('n', ',<space>', '<cmd>:nohlsearch<CR>') -- turn off search highlight
-- Setup easymotion END

-- Setup neo-tree (file tree + buffer-tree)
require("neo-tree").setup({
  enable_diagnostics = false,
  enable_git_status = false,
  window = {
    width = 40,
    position = "left",

    mapping_options = {
      noremap = true,
      nowait = true,
    },
    mappings = {
      ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = false } },
    }
  },
  filesystem = {
    follow_current_file = {
      enabled = true, -- This will find and focus the file in the active buffer every time
      --              -- the current file is changed while the tree is open.
      leave_dirs_open = true, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
	  },
  },
  buffers = {
    follow_current_file = {
      enabled = true, -- This will find and focus the file in the active buffer every time
      --              -- the current file is changed while the tree is open.
      leave_dirs_open = true, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
	  },
  },
  event_handlers = {
    --[[
    {
      event = "file_opened",
      handler = function(file_path)
        require("neo-tree.command").execute({ action = "close" })
      end
    },
    ]]--
  },
  default_component_configs = {
    file_size = {
      enabled = false,
    },
    type = {
      enabled = true,
      required_width = 80, -- min width of window required to show this column
    },
    last_modified = {
      enabled = false,
    },
    created = {
      enabled = false,
    },
    symlink_target = {
      enabled = false,
    },
  }
})
vim.keymap.set('n', '<C-t>', '<cmd>:Neotree reveal <CR>')
vim.keymap.set('n', 'ga', '<cmd>:Neotree buffers reveal <CR>')
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


vim.o.termguicolors = true
vim.o.background = "dark"

-- Setup colour theme
require("gruvbox").setup({
  terminal_colors = true, -- add neovim terminal colors
  undercurl = true,
  underline = true,
  bold = true,
  italic = {
    strings = false,
    emphasis = true,
    comments = true,
    operators = false,
    folds = true,
  },
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = true,
  invert_intend_guides = false,
  inverse = false, -- invert background for search, diffs, statuslines and errors
  contrast = "hard", -- can be "hard", "soft" or empty string
  palette_overrides = {},
  overrides = {},
  dim_inactive = false,
  transparent_mode = false,
})
require("tokyonight").setup({
  style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
  transparent = false, -- Enable this to disable setting the background color
  terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
  styles = {
    -- Style to be applied to different syntax groups
    -- Value is any valid attr-list value for `:help nvim_set_hl`
    comments = { italic = true },
    keywords = { italic = true },
    functions = {},
    variables = {},
    -- Background styles. Can be "dark", "transparent" or "normal"
    sidebars = "transparent", -- style for sidebars, see below
    floats = "transparent", -- style for floating windows
  },
  sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
  day_brightness = 0.8, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
  hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
  dim_inactive = false, -- dims inactive windows
  lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

  --- You can override specific color groups to use other groups or a hex color
  --- function will be called with a ColorScheme table
  ---@param colors ColorScheme
  on_colors = function(colors) end,

  --- You can override specific highlights to use other groups or a hex color
  --- function will be called with a Highlights and ColorScheme table
  ---@param highlights Highlights
  ---@param colors ColorScheme
  on_highlights = function(highlights, colors) end,
})
require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    background = { -- :h background
        light = "latte",
        dark = "mocha",
    },
    transparent_background = false, -- disables setting the background color.
    show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
    term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    no_underline = false, -- Force no underline
    styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { "italic" }, -- Change the style of comments
        conditionals = { },
        loops = { },
        functions = { },
        keywords = { "italic" },
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
        -- miscs = {}, -- Uncomment to turn off hard-coded styles
    },
    color_overrides = {},
    custom_highlights = {},
    default_integrations = true,
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = true,
        barbar = true,
        mini = {
            enabled = true,
            indentscope_color = "",
        },
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
})
-- setup must be called before loading
vim.cmd("colorscheme nightfox")

vim.opt.guicursor = "c-ci-i:ver25"
--vim.g.nightflyNormalFloat = true
-- Setup colour theme END

-- Setup noice (cmd + notifications UI)
require("noice").setup({
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
    },
    progress = {
      enabled = true,
      -- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
      -- See the section on formatting for more details on how to customize.
      --- @type NoiceFormat|string
      format = "lsp_progress",
      --- @type NoiceFormat|string
      format_done = "lsp_progress_done",
      throttle = 250, -- frequency to update lsp progress message
      view = "mini",
    },
    signature = {
      enabled = true,
      auto_open = {
        enabled = true,
        trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
        luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
        throttle = 50, -- Debounce lsp signature help request by 50ms
      },
      view = nil, -- when nil, use defaults from documentation
      ---@type NoiceViewOptions
      opts = {}, -- merged with defaults from documentation
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = false, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = false, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = true, -- add a border to hover docs and signature help
  },
  throttle = 150, -- check for updates??
  log = vim.fn.stdpath("state") .. "/noice.log",
  log_max_size = 1024 * 1024 * 2, -- 10MB
})

local notify = require("notify")
vim.keymap.set('n', '<ESC>', notify.dismiss, {})
notify.setup({
  background_colour = "#000000",
  stages="static",
  fps = 15,
  render="default",
  timeout=5000,
})
--
--
-- Setup noice END


-- Setup lualine (line in bottom)
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme  = "ayu_mirage",
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

vim.diagnostic.config {
  signs = true,
  underline = true,
  virtual_text = false,
  virtual_lines = false,
  update_in_insert = false,
  severity_sort = true,
  float = {
    -- UI.
    header = false,
    border = 'rounded',
    focusable = true,
  }
}

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local builtin = require('telescope.builtin')
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf, silent = true }

    vim.keymap.set('n', 'gd', builtin.lsp_definitions, opts)
    vim.keymap.set('n', 'gi', builtin.lsp_implementations, opts)
    vim.keymap.set('n', 'gr', builtin.lsp_references, opts)

    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)

--    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
--    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
--    vim.keymap.set('n', '<space>wl', function()
--      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--    end, opts)
    vim.keymap.set('n', '<space>D', builtin.lsp_type_definitions, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)

    vim.keymap.set({ 'n', 'v' }, '<space>ca', function ()
      if vim.bo.filetype == 'rust' then
        vim.cmd.RustLsp('codeAction')
      else
        vim.lsp.buf.code_action()
      end
    end, opts)

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
        -- Logging level of the language server. Logs appear in :LspLog. Defaults to error.
        cmd_env = { RUST_LOG = "error" }
    },
    init_options = {
        -- Custom config. Used together with any workspace config files, taking precedence for
        -- settings declared in both. Equivalent to the typos `--config` cli argument.
        config = '~/.config/nvim/typos.toml',
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
--    { name = 'luasnip', keyword_length = 3 },
  },
  window = {
    documentation = cmp.config.window.bordered()
  },
  formatting = {
    fields = {'menu', 'abbr', 'kind'},
    format = function(entry, item)
      local menu_icon = {
        nvim_lsp = 'λ',
        -- buffer = 'Ω',
        path = '∫',
        -- luasnip = '†',
      }

      item.menu = menu_icon[entry.source.name]
      return item
    end,
  },
}

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "cpp", "rust", "python", "lua", "vim", "vimdoc", "git_rebase", "gitcommit", "regex" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = false,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = true,
  },
}

--[[
-- FIXME
-- DIRTY HACK!!!
-- rustaceanvim plugin contains such code, which lead to crates in /vendor/ mapped to another crate dir. we want remap it into root_dir
local cargo_crate_dir = vim.fs.dirname(vim.fs.find({ 'Cargo.toml' }, {
  upward = true,
  path = path,
})[1])
]]--

local find_orig = vim.fs.find
vim.fs.find = function(what, where)
  if what[1] == 'Cargo.toml' then
    if string.find(where['path'], '/vendor/') then
      local vendor = find_orig({ 'vendor' }, where)[1]
      vim.notify(string.format("vim.fs.find(`%s`) in `%s` was remappend into `%s`", what[1], where['path'], vendor))

      return find_orig(what, { upward = where['upward'], path = vendor })
    end
  end

  return find_orig(what, where)
end

vim.g.rustaceanvim = {
  -- Plugin configuration
  tools = {
    reload_workspace_from_cargo_toml = false,
  },
  server = {
    ---@param project_root string Path to the project root
    settings = function(project_root)
      return {
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
    end,
  },
  -- DAP configuration
  dap = {
  },
}
