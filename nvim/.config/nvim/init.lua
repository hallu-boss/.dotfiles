vim.pack.add {
	'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/nvim-mini/mini.nvim',
}

require('mason').setup()
vim.lsp.enable {
  'lua_ls', 'vtsls',
}

require('mini.icons').setup()
require('mini.surround').setup()
require('mini.pick').setup()
require('mini.files').setup()
require('mini.git').setup()
require('mini.cmdline').setup()
require('mini.completion').setup()

require('mini.diff').setup({
  view = {
    style = 'sign',
    signs = { add = '+', change = '~', delete = '-' },
  },
})

require('mini.hues').setup({ background = '#070912', foreground = '#c4c6cd' })

local extra = require('mini.extra')
extra.setup()
require('mini.ai').setup({
  custom_textobjects = {
    B = extra.gen_ai_spec.buffer(),
  }
})

require('neovide')

vim.cmd.packadd('cfilter')
vim.cmd.packadd('nvim.undotree')
vim.cmd.packadd('nvim.difftool')

require('vim._core.ui2').enable()

vim.g.mapleader = ' '
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'yes'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.confirm = true
vim.opt.termguicolors = true
vim.opt.statusline = "%<%f %h%m%r%{%get(b:, 'minigit_summary_string', '')%}%=%-14.(%l,%c%V%) %P"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set({ 'n', 'x' }, '<leader>y', '"+y')

vim.keymap.set('n', '<leader>e', '<cmd>lua MiniFiles.open()<CR>')

vim.keymap.set('n', '<leader>f', '<cmd>Pick files<CR>')
vim.keymap.set('n', '<leader>b', '<cmd>Pick buffers<CR>')
vim.keymap.set('n', '<leader>\'', '<cmd>Pick resume<CR>')
vim.keymap.set('n', '<leader>/', '<cmd>Pick grep_live<CR>')
vim.keymap.set('n', '<leader>?', '<cmd>Pick help<CR>')
vim.keymap.set('n', '<leader>h', '<cmd>Pick git_hunks<CR>')
vim.keymap.set('n', '<leader>k', '<cmd>Pick keymaps<CR>')
vim.keymap.set('n', '<leader>w', '<cmd>Pick grep pattern="<cword>"<CR>')
vim.keymap.set('n', '<leader>m', '<cmd>Pick marks<CR>')
vim.keymap.set('n', '<leader>.', '<cmd>Pick oldfiles<CR>')
vim.keymap.set('n', '<leader>j', '<cmd>Pick list scope="jump"<CR>')

vim.keymap.set('n', '<leader>gb', '<cmd>Pick git_branches<CR>')
vim.keymap.set('n', '<leader>gc', '<cmd>Pick git_commits<CR>')
vim.keymap.set('n', '<leader>gs', '<cmd>lua MiniGit.show_at_cursor()<CR>')

vim.keymap.set('n', '<leader>t', ':terminal<CR>a')

vim.keymap.set('n', 'grr', '<cmd>Pick lsp scope="references"<CR>')
vim.keymap.set('n', 'gri', '<cmd>Pick lsp scope="implementation"<CR>')
vim.keymap.set('n', 'grd', '<cmd>Pick lsp scope="definition"<CR>')
vim.keymap.set('n', 'gO', '<cmd>Pick lsp scope="document_symbol"<CR>')
vim.keymap.set('n', 'gW', '<cmd>Pick lsp scope="workspace_symbol_live"<CR>')
vim.keymap.set('n', 'grt', '<cmd>Pick lsp scope="type_definition"<CR>')

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function() vim.highlight.on_yank() end,
})


