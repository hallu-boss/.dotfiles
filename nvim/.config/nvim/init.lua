vim.pack.add {
	'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/tpope/vim-fugitive',
  'https://github.com/nvim-mini/mini.nvim',
}

vim.cmd.colorscheme('habamax')
vim.cmd.colorscheme('default')

vim.cmd.packadd('cfilter')
vim.cmd.packadd('nvim.undotree')
vim.cmd.packadd('nvim.difftool')

require('vim._core.ui2').enable()

require('mini.icons').setup()
require('mini.pick').setup()
require('mini.completion').setup()
require('mini.diff').setup()
require('mini.cmdline').setup()

-- NEOVIDE
if vim.g.neovide then
  vim.o.guifont = "CommitMono Nerd Font:h14"

	vim.keymap.set('n', '<C-s-v>', '"+p')
	vim.keymap.set('i', '<C-s-v>', '<C-r>+')
	vim.keymap.set('t', '<C-s-v>', '<C-\\><C-o>"+p')
end

-- LSP
require('mason').setup()
vim.lsp.enable {
  'lua_ls', 'vtsls',
}

local config = {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      workspace = {
        library = {
          vim.env.VIMRUNTIME,
        }
      },
    },
  },
}

vim.lsp.config('lua_ls', config)

-- OPTIONS
vim.g.mapleader = ' '
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'yes'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.confirm = true
vim.opt.termguicolors = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.winborder = 'single'
vim.opt.statusline = "%<%f %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%) %P"

-- KEYMAPS
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set({ 'n', 'x' }, '<leader>y', '"+y')
vim.keymap.set('n', '<leader>t', ':terminal<CR>a')

vim.keymap.set('n', '<leader>e', '<cmd>lua MiniFiles.open()<CR>')

vim.keymap.set('n', '<leader>.', '<cmd>browse oldfiles<CR>')
vim.keymap.set('n', '<leader>f', '<cmd>Pick files<CR>')
vim.keymap.set('n', '<leader>b', '<cmd>Pick buffers<CR>')
vim.keymap.set('n', '<leader>/', '<cmd>Pick grep_live<CR>')
vim.keymap.set('n', '<leader>w', '<cmd>Pick grep pattern="<cword>"<CR>')
vim.keymap.set('n', '<leader>\'', '<cmd>Pick resume<CR>')
vim.keymap.set('n', '<leader>?', '<cmd>Pick help<CR>')
vim.keymap.set('n', '<leader>g', '<cmd>tab G<CR>')

-- AUTOCOMMANDS
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function() vim.highlight.on_yank() end,
})

vim.api.nvim_create_autocmd('FileType', {
    callback = function() pcall(vim.treesitter.start) end,
})


local MiniFiles = require('mini.files')
MiniFiles.setup()

-- Set focused directory as current working directory
local set_cwd = function()
  local path = (MiniFiles.get_fs_entry() or {}).path
  if path == nil then return vim.notify('Cursor is not on valid entry') end
  vim.fn.chdir(vim.fs.dirname(path))
end

-- Yank in register full path of entry under cursor
local yank_path = function()
  local path = (MiniFiles.get_fs_entry() or {}).path
  if path == nil then return vim.notify('Cursor is not on valid entry') end
  vim.fn.setreg(vim.v.register, path)
end

-- Open path with system default handler (useful for non-text files)
local ui_open = function() vim.ui.open(MiniFiles.get_fs_entry().path) end

vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesBufferCreate',
  callback = function(args)
    local b = args.data.buf_id
    vim.keymap.set('n', 'g~', set_cwd,   { buffer = b, desc = 'Set cwd' })
    vim.keymap.set('n', 'gX', ui_open,   { buffer = b, desc = 'OS open' })
    vim.keymap.set('n', 'gy', yank_path, { buffer = b, desc = 'Yank path' })
  end,
})

local set_mark = function(id, path, desc)
    MiniFiles.set_bookmark(id, path, { desc = desc })
  end
  vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesExplorerOpen',
    callback = function()
      set_mark('c', vim.fn.stdpath('config'), 'Config')
      set_mark('w', vim.fn.getcwd, 'Working directory')
      set_mark('~', '~', 'Home directory')
      set_mark('d', '~/Downloads', 'Downloads directory')
    end,
  })

