vim.pack.add {
	'https://github.com/nvim-treesitter/nvim-treesitter',
	'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/nvim-mini/mini.nvim',
}

require('mason').setup()
vim.lsp.enable {
  'lua_ls', 'vtsls',
}

require('mini.icons').setup()
require('mini.ai').setup()
require('mini.surround').setup()
require('mini.pick').setup()
require('mini.files').setup()
require('mini.git').setup()
require('mini.cmdline').setup()
require('mini.completion').setup()
require('mini.extra').setup()
require('mini.diff').setup({
  view = {
    style = 'sign',
    signs = { add = '+', change = '~', delete = '-' },
  },
})
require('mini.hues').setup({ background = '#070912', foreground = '#c4c6cd' })


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
vim.opt.foldlevel = 999
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
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

vim.keymap.set('n', '<leader>t', ':terminal<CR>a')

-- local builtin = require 'telescope.builtin'
-- vim.keymap.set('n', '<leader>f', builtin.find_files)
-- vim.keymap.set('n', '<leader>b', builtin.buffers)
-- vim.keymap.set('n', '<leader>.', builtin.oldfiles)
-- vim.keymap.set('n', '<leader>t', ':terminal<CR>a')
-- vim.keymap.set('n', '<leader>/', builtin.live_grep)
-- vim.keymap.set('n', '<leader>?', builtin.help_tags)
-- vim.keymap.set('n', '<leader>k', builtin.keymaps)
-- vim.keymap.set('n', '<leader>j', builtin.jumplist)
-- vim.keymap.set('n', '<leader>s', builtin.lsp_document_symbols)
-- vim.keymap.set('n', '<leader>d', builtin.diagnostics)
-- vim.keymap.set('n', '<leader>\'', builtin.resume)
-- vim.keymap.set({ 'n', 'x' }, '<leader>w', builtin.grep_string)

-- vim.keymap.set('n', 'grr', builtin.lsp_references)
-- vim.keymap.set('n', 'gri', builtin.lsp_implementations)
-- vim.keymap.set('n', 'grd', builtin.lsp_definitions)
-- vim.keymap.set('n', 'gO', builtin.lsp_document_symbols)
-- vim.keymap.set('n', 'gW', builtin.lsp_dynamic_workspace_symbols)
-- vim.keymap.set('n', 'grt', builtin.lsp_type_definitions)

vim.api.nvim_create_autocmd('FileType', {
    callback = function() pcall(vim.treesitter.start) end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function() vim.highlight.on_yank() end,
})
