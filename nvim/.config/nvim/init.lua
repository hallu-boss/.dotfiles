vim.pack.add {
	'https://github.com/nvim-treesitter/nvim-treesitter',
	'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/mason-org/mason.nvim',
	'https://github.com/stevearc/oil.nvim',
	'https://github.com/vague-theme/vague.nvim',
	'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/tpope/vim-fugitive',
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-telescope/telescope.nvim',
  'https://github.com/nvim-telescope/telescope-ui-select.nvim',
  'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
}

require('mason').setup()
vim.lsp.enable {
  'lua_ls', 'vtsls',
}

require('neovide')
require('find')

vim.cmd.packadd('cfilter')
vim.cmd.packadd('nvim.undotree')
vim.cmd.packadd('nvim.difftool')

require('oil').setup()

require('vim._core.ui2').enable()

vim.cmd.colorscheme('vague')

vim.g.mapleader = ' '
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'yes'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.completeopt = 'menu,menuone,fuzzy,noinsert'
vim.opt.confirm = true
vim.opt.termguicolors = true
vim.opt.wildoptions:append { 'fuzzy' }
vim.opt.statusline = '%<%f %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%) %P'
vim.opt.foldlevel = 999
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

require('telescope').setup {
  extensions = {
    ['ui-select'] = { require('telescope.themes').get_dropdown() },
  },
}

pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')


vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '-', '<cmd>Oil<CR>')

local builtin = require 'telescope.builtin'
vim.keymap.set('n', '<leader>f', builtin.find_files)
vim.keymap.set('n', '<leader>b', builtin.buffers)
vim.keymap.set('n', '<leader>.', builtin.oldfiles)
vim.keymap.set('n', '<leader>t', ':terminal<CR>a')
vim.keymap.set('n', '<leader>/', builtin.live_grep)
vim.keymap.set('n', '<leader>?', builtin.help_tags)
vim.keymap.set('n', '<leader>k', builtin.keymaps)
vim.keymap.set('n', '<leader>j', builtin.jumplist)
vim.keymap.set('n', '<leader>s', builtin.lsp_document_symbols)
vim.keymap.set('n', '<leader>d', builtin.diagnostics)
vim.keymap.set('n', '<leader>\'', builtin.resume)
vim.keymap.set({ 'n', 'x' }, '<leader>w', builtin.grep_string)

vim.api.nvim_create_autocmd('FileType', {
    callback = function() pcall(vim.treesitter.start) end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function() vim.highlight.on_yank() end,
})
