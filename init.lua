-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost',
    { command = 'source <afile> | PackerCompile', group = packer_group, pattern = 'init.lua' })

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
    use "hrsh7th/cmp-nvim-lsp-signature-help"
    use "hrsh7th/cmp-nvim-lua"
    use 'saadparwaiz1/cmp_luasnip'
    use 'L3MON4D3/LuaSnip' -- Snippets plugin

    -- use 'nvimdev/lspsaga.nvim'
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
            "3rd/image.nvim",              -- Optional image support in preview window: See `# Preview Mode` for more information
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
        after = "nvim-web-devicons",       -- keep this if you're using NvChad
        config = function()
            require("barbecue").setup()
        end,
    })

    use { 'junegunn/fzf', run = ":call fzf#install()" }
    use 'junegunn/fzf.vim'
    use {
        'lewis6991/gitsigns.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
    }

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use 'ntpeters/vim-better-whitespace'

    -- LSP server
    use "mason-org/mason.nvim"

    use 'nvim-treesitter/nvim-treesitter'
    use 'nvim-treesitter/nvim-treesitter-textobjects'

    use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
    -- Plug 'nvim-lua/lsp-status.nvim'

    -- LSP Modules
    use 'tekumara/typos-lsp'
    use 'rust-lang/rust.vim'

    use {
        'mrcjkb/rustaceanvim',
        version = '^7', -- Recommended
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
    use { 'AlexvZyl/nordic.nvim' }
    use "EdenEast/nightfox.nvim"

    -- use 'octol/vim-cpp-enhanced-highlight'
    --Plug 'mhartington/oceanic-next'  " colorscheme OceanicNext
    --Plug 'kaicataldo/material.vim', { 'branch': 'main' }
    --Plug 'ayu-theme/ayu-vim'

    use 'thaerkh/vim-workspace'

    --Plug 'rmagatti/goto-preview'

    -- statusline
    use 'echasnovski/mini.icons'
    use 'nvim-tree/nvim-web-devicons'
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
    use 'romgrk/barbar.nvim'

    use 'stevearc/profile.nvim'

    use "johnseth97/codex.nvim"
    use {
        "coder/claudecode.nvim",
        requires = { "folke/snacks.nvim" },
    }
    use "folke/which-key.nvim"
    use "numToStr/Comment.nvim"
    use { "akinsho/toggleterm.nvim", tag = "*" }
end)


-- Core Settings
vim.o.mouse = "a"
vim.o.encoding = "utf-8"
vim.o.number = true
vim.o.swapfile = false
vim.o.scrolloff = 7
vim.o.updatetime = 1000

vim.opt.guicursor = "c-ci-i-t:ver25"
vim.opt.smoothscroll = true

-- Highlight the active window only.
local active_win_group = vim.api.nvim_create_augroup("ActiveWindowHighlight", { clear = true })
vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter" }, {
    group = active_win_group,
    callback = function()
        vim.wo.cursorline = true
    end,
})
vim.api.nvim_create_autocmd("WinLeave", {
    group = active_win_group,
    callback = function()
        vim.wo.cursorline = false
    end,
})

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.fileformat = "unix"

-- Resize splits with hotkeys.
vim.keymap.set('n', '<C-S-k>', '<cmd>resize +2<CR>')
vim.keymap.set('n', '<C-S-j>', '<cmd>resize -2<CR>')
vim.keymap.set('n', '<C-S-h>', '<cmd>vertical resize -2<CR>')
vim.keymap.set('n', '<C-S-l>', '<cmd>vertical resize +2<CR>')

-- Toggleterm handles TT mapping below.
--TODO: vim.o.indent = "on"    -- load filetype-specific indent files
--
-- vim.keymap.set('t', '<ESC>', '<C-\\><C-n>')
-- Core Settings END


-- Git signs/blame
local gitsigns = require('gitsigns')
gitsigns.setup {
    signcolumn = false,
    numhl = false,
    linehl = false,
    current_line_blame = false,
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol',
        delay = 500,
        ignore_whitespace = false,
    },
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
}
vim.g.gitsigns_enabled = false
local function set_gitsigns_enabled(enabled)
    gitsigns.toggle_signs(enabled)
    gitsigns.toggle_numhl(enabled)
    gitsigns.toggle_linehl(enabled)
    gitsigns.toggle_current_line_blame(enabled)
end
vim.api.nvim_create_user_command("GitsignsToggle", function()
    local enabled = not vim.g.gitsigns_enabled
    set_gitsigns_enabled(enabled)
    vim.g.gitsigns_enabled = enabled
    vim.notify(enabled and "Gitsigns enabled" or "Gitsigns disabled")
end, {})
-- Git signs/blame END


-- Setup devicons (requires by many plugings)
require('nvim-web-devicons').setup { default = true, }

require("Comment").setup()

local function focus_or_toggle(opts)
    local current_win = vim.api.nvim_get_current_win()
    local target_win = nil
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        if opts.match(buf) then
            target_win = win
            break
        end
    end

    if target_win then
        if target_win ~= current_win then
            vim.api.nvim_set_current_win(target_win)
            return
        end
    end

    if type(opts.command) == "function" then
        opts.command()
    else
        vim.cmd(opts.command)
    end
end

require("toggleterm").setup({
    open_mapping = nil,
})
vim.keymap.set('n', '<leader>t', function()
    focus_or_toggle({
        match = function(buf)
            return vim.api.nvim_get_option_value("filetype", { buf = buf }) == "toggleterm"
        end,
        command = "ToggleTerm",
    })
end)
require('mini.icons').setup()
-- Setup devicons END


-- Setup telescope (fzf-like search plugin)
require('telescope').setup {
    pickers = {
        lsp_references = {
            initial_mode = "normal"
        },
        diagnostics = {
            initial_mode = "normal"
        },
    },
    defaults = { file_ignore_patterns = { "vendor" } }
}
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fa', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fm', builtin.marks, {})
vim.keymap.set('n', '<leader>fh', builtin.search_history, {})
vim.keymap.set('n', '<leader>fc', builtin.current_buffer_fuzzy_find, {})
vim.keymap.set('', '<c-z>', '<Cmd>:sus!<CR>')

vim.keymap.set('n', '<leader>dl', builtin.diagnostics, {})
require("telescope").load_extension("noice")
require("telescope").load_extension("notify")
-- Setup telescope END


-- Setup barbar (a tab-bar in top)
require 'barbar'.setup {
    -- Excludes buffers from the tabline TODO
    -- exclude_ft = {'javascipt'},
    -- exclude_name = {'package.json'},
    tabpages = true,
    animation = false,
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
hop.setup {
    jump_on_sole_occurrence = false,
    case_insensitive = true,
    create_hl_autocmd = true,
}
vim.keymap.set('', '/a', function()
    hop.hint_anywhere()
end, { remap = true })

vim.keymap.set('n', '/s', function()
    hop.hint_char1()
end, { remap = true })
vim.keymap.set('n', '/f', function()
    hop.hint_patterns()
end, { remap = true })
vim.keymap.set('n', '//', '/')
vim.keymap.set('n', ',<space>', '<cmd>:nohlsearch<CR>') -- turn off search highlight
-- Setup easymotion END

-- Setup codex
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')                -- <Esc> to exit from terminal Input mode
vim.keymap.set('n', '<leader>c', function()
    focus_or_toggle({
        match = function(buf)
            local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })
            if ft == "codex" then
                return true
            end
            local name = vim.api.nvim_buf_get_name(buf):lower()
            return name:find("codex", 1, true) ~= nil
        end,
        command = "CodexToggle",
    })
end)
require("codex").setup({
    keymaps     = {
        toggle = nil,        -- Keybind to toggle Codex window (Disabled by default, watch out for conflicts)
        quit = '<C-q>',      -- Keybind to close the Codex window (default: Ctrl + q)
    },                       -- Disable internal default keymap (<leader>cc -> :CodexToggle)
    border      = 'rounded', -- Options: 'single', 'double', or 'rounded'
    width       = 0.4,       -- Width of the floating window (0.0 to 1.0)
    height      = 0.8,       -- Height of the floating window (0.0 to 1.0)
    model       = nil,       -- Optional: pass a string to use a specific model (e.g., 'o3-mini')
    autoinstall = true,      -- Automatically install the Codex CLI if not found
    panel       = true,      -- Open Codex in a side-panel (vertical split) instead of floating window
    use_buffer  = false,     -- Capture Codex stdout into a normal buffer instead of a terminal buffer
})

-- Setup claudecode
require("claudecode").setup({
    terminal = {
        split_side = "right",
        split_width_percentage = 0.5,
    },
    diff_opts = {
        auto_close_on_accept = true,
        vertical_split = true,
        open_in_current_tab = true,
    },
    inline_diff = true,
})
vim.keymap.set('n', '<leader>v', '<cmd>ClaudeCode<CR>')
vim.api.nvim_create_autocmd("TermOpen", {
    callback = function(args)
        local name = vim.api.nvim_buf_get_name(args.buf):lower()
        if name:find("claude", 1, true) then
            vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { buffer = args.buf })
        end
    end,
})
-- Setup claudecode END

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
            enabled = true,         -- This will find and focus the file in the active buffer every time
            --              -- the current file is changed while the tree is open.
            leave_dirs_open = true, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
        },
    },
    buffers = {
        follow_current_file = {
            enabled = true,         -- This will find and focus the file in the active buffer every time
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
    ]] --
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
vim.keymap.set('n', '<leader>n', function()
    focus_or_toggle({
        match = function(buf)
            return vim.api.nvim_get_option_value("filetype", { buf = buf }) == "neo-tree"
        end,
        command = "Neotree toggle",
    })
end)
vim.keymap.set('n', 'ga', '<cmd>:Neotree buffers reveal <CR>')
-- Setup neo-tree END


-- Setup workspace plugin
vim.g.workspace_autocreate = 0
vim.g.workspace_create_new_tabs = 0
vim.g.workspace_session_directory = os.getenv("HOME") .. "/.config/nvim/sessions/"
vim.g.workspace_undodir = os.getenv("HOME") .. '/.config/nvim/sessions/.undodir'

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
require("colorscheme")
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
                throttle = 50,  -- Debounce lsp signature help request by 50ms
            },
            view = nil,         -- when nil, use defaults from documentation
            ---@type NoiceViewOptions
            opts = {},          -- merged with defaults from documentation
        },
    },
    -- you can enable a preset for easier configuration
    presets = {
        bottom_search = false,         -- use a classic bottom cmdline for search
        command_palette = true,        -- position the cmdline and popupmenu together
        long_message_to_split = false, -- long messages will be sent to a split
        inc_rename = false,            -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true,         -- add a border to hover docs and signature help
    },
    throttle = 150,                    -- check for updates??
    log = vim.fn.stdpath("state") .. "/noice.log",
    log_max_size = 1024 * 1024 * 2,    -- 10MB
})

local notify = require("notify")
vim.keymap.set('n', '<ESC>', notify.dismiss, {})
notify.setup({
    background_colour = "#000000",
    stages = "static",
    fps = 15,
    render = "default",
    timeout = 5000,
})
-- Setup noice END


-- Setup which-key
require("which_key")
-- Setup which-key END


-- Setup lualine (line in bottom)
local function lualine_selection_count()
    local mode = vim.fn.mode()
    if mode ~= "v" and mode ~= "V" and mode ~= "\22" then
        return ""
    end

    local wc = vim.fn.wordcount()
    local bytes = wc.visual_bytes or 0
    if bytes == 0 then
        return ""
    end

    return "Selected:" .. bytes
end

require('lualine').setup {
    options = {
        icons_enabled        = true,
        theme                = "ayu_mirage",
        component_separators = { left = '', right = '' },
        section_separators   = { left = '', right = '' },
        disabled_filetypes   = {},
        always_divide_middle = true,
        globalstatus         = true,
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = {
            {
                'searchcount',
                maxcount = 999,
                timeout = 500,
            },
        },
        lualine_x = {
            {
                require("noice").api.statusline.mode.get,
                cond = require("noice").api.statusline.mode.has,
                color = { fg = "#ff9e64" },
            },
            'location',
            lualine_selection_count,
            'encoding'
        },
        lualine_y = {
            {
                'filetype',
                colored = true,
                icon_only = true,
            },
        },
        lualine_z = { "os.date('%X')" }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    extensions = {}
}
-- Setup lualine END


-- Setup code-complete-plugin + LSP
require("lsp")
