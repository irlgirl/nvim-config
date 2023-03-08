lua << EOF

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
  use "williamboman/nvim-lsp-installer"
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client

  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin,
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"

  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip' -- Snippets plugin

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


EOF


set mouse=a  " enable mouse
set encoding=utf-8
set number
set noswapfile
set scrolloff=7

set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
set fileformat=unix
filetype indent on      " load filetype-specific indent files

call plug#begin('~/.vim/plugged')

Plug 'tklepzig/vim-buffer-navigator'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'preservim/nerdtree'

" color schemas
Plug 'morhetz/gruvbox'  " colorscheme gruvbox
Plug 'octol/vim-cpp-enhanced-highlight'
"Plug 'mhartington/oceanic-next'  " colorscheme OceanicNext
"Plug 'kaicataldo/material.vim', { 'branch': 'main' }
"Plug 'ayu-theme/ayu-vim'

" For JS/JSX
" Plug 'yuezk/vim-js'
" Plug 'maxmellon/vim-jsx-pretty'
" Plug 'nvim-lua/lsp-status.nvim'
"
Plug 'easymotion/vim-easymotion'

Plug 'airblade/vim-gitgutter'

Plug 'schickling/vim-bufonly'

Plug 'ntpeters/vim-better-whitespace'
Plug 'thaerkh/vim-workspace'

"Plug 'rmagatti/goto-preview'
call plug#end()

let g:gitgutter_enabled = 0

"set termguicolors
"let &t_8f = \"\<Esc>[38;2;%lu;%lu;%lum"
"let &t_8b = \"\<Esc>[48;2;%lu;%lu;%lum"

set background=dark

colorscheme gruvbox
"colorscheme OceanicNext
let g:material_terminal_italics = 1
" variants: default, palenight, ocean, lighter, darker, default-community,
"           palenight-community, ocean-community, lighter-community,
"           darker-community
" let g:material_theme_style = 'darker'
" colorscheme material

" variants: mirage, dark, dark
"let ayucolor="mirage"
"colorscheme ayu

" Delete buffer while keeping window layout (don't close buffer's windows).
" Version 2008-11-18 from http://vim.wikia.com/wiki/VimTip165
if v:version < 700 || exists('loaded_bclose') || &cp
  finish
endif
let loaded_bclose = 1
if !exists('bclose_multiple')
  let bclose_multiple = 1
endif

" Display an error message.
function! s:Warn(msg)
  echohl ErrorMsg
  echomsg a:msg
  echohl NONE
endfunction

" Command ':Bclose' executes ':bd' to delete buffer in current window.
" The window will show the alternate buffer (Ctrl-^) if it exists,
" or the previous buffer (:bp), or a blank buffer if no previous.
" Command ':Bclose!' is the same, but executes ':bd!' (discard changes).
" An optional argument can specify which buffer to close (name or number).
function! s:Bclose(bang, buffer)
  if empty(a:buffer)
    let btarget = bufnr('%')
  elseif a:buffer =~ '^\d\+$'
    let btarget = bufnr(str2nr(a:buffer))
  else
    let btarget = bufnr(a:buffer)
  endif
  if btarget < 0
    call s:Warn('No matching buffer for '.a:buffer)
    return
  endif
  if empty(a:bang) && getbufvar(btarget, '&modified')
    call s:Warn('No write since last change for buffer '.btarget.' (use :Bclose!)')
    return
  endif
  " Numbers of windows that view target buffer which we will delete.
  let wnums = filter(range(1, winnr('$')), 'winbufnr(v:val) == btarget')
  if !g:bclose_multiple && len(wnums) > 1
    call s:Warn('Buffer is in multiple windows (use ":let bclose_multiple=1")')
    return
  endif
  let wcurrent = winnr()
  for w in wnums
    execute w.'wincmd w'
    let prevbuf = bufnr('#')
    if prevbuf > 0 && buflisted(prevbuf) && prevbuf != btarget
      buffer #
    else
      bprevious
    endif
    if btarget == bufnr('%')
      " Numbers of listed buffers which are not the target to be deleted.
      let blisted = filter(range(1, bufnr('$')), 'buflisted(v:val) && v:val != btarget')
      " Listed, not target, and not displayed.
      let bhidden = filter(copy(blisted), 'bufwinnr(v:val) < 0')
      " Take the first buffer, if any (could be more intelligent).
      let bjump = (bhidden + blisted + [-1])[0]
      if bjump > 0
        execute 'buffer '.bjump
      else
        execute 'enew'.a:bang
      endif
    endif
  endfor
  execute 'bdelete'.a:bang.' '.btarget
  execute wcurrent.'wincmd w'
endfunction
command! -bang -complete=buffer -nargs=? Bclose call <SID>Bclose(<q-bang>, <q-args>)
nnoremap <silent> <Leader>bd :Bclose<CR>


map <C-k> :bn<cr>
map <C-j> :bp<cr>
map gw :Bclose<cr>
map gon :BOnly<cr>

"set colorcolumn=119

" easymotion
let g:EasyMotion_smartcase = 1

" disable default buffer navigator
let g:BufferNavigatorMapKeys = 0
map ga :BufferNavigatorToggle<cr>
let g:BufferNavigatorHighlightRules = [
    \["CppFile", "file", ".*\\.cpp", "NONE", "red", "NONE", "red"],
    \["CppHeader", "file", ".*\\.h", "NONE", "green", "NONE", "green"],
    \["TLFile", "file", ".*\\.tl", "NONE", "cyan", "NONE", "cyan"],
    \["Txt", "file", ".*\\.txt", "NONE", "white", "NONE", "white"],
    \["LogTxt", "file", ".*\\.log", "NONE", "white", "NONE", "white"],
    \["CommonDirectory", "dir", "common", "NONE", "yellow", "NONE", "yellow"],
    \]

map <Leader> <Plug>(easymotion-prefix)
nmap s <Plug>(easymotion-overwin-f)

map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
 
" These `n` & `N` mappings are options. You do not have to map `n` & `N` to EasyMotion.
" Without these mappings, `n` & `N` works fine. (These mappings just provide
" different highlight method and have some other features )
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

" nnoremap <C-t> :NERDTreeFocus<CR>
nnoremap <C-t> :NERDTreeToggle<CR>

let g:workspace_autocreate = 1

" C++ highlighting
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1
let g:cpp_no_function_highlight = 1

" turn off search highlight
nnoremap ,<space> :nohlsearch<CR>



lua << EOF

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

vim.lsp.set_log_level("ERROR")

local custom_gruvbox = require'lualine.themes.gruvbox'

-- Change the background of lualine_c section for normal mode
-- custom_gruvbox.normal.c.bg = '#112233'

require('nvim-web-devicons').setup {
   default = true;
}
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme  = custom_gruvbox,
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename', 'location'},
    lualine_x = {'encoding'},
    lualine_y = {
      {
        'buffers',
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

local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
--not ready yet
--buf_set_keymap("n", "J", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", opts)
--buf_set_keymap("n", "gR", "<cmd>lua require('goto-preview').goto_preview_references()<CR>", opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
--  buf_set_keymap('i', '<C-b>', '<cmd>lua vim.lsp.buf.completion()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('v', 'ff', '<ESC><cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)

end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

nvim_lsp.clangd.setup {
  on_attach = on_attach,
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
  on_attach = on_attach,
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
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = capabilities,
  settings = {
  }
}

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
EOF
