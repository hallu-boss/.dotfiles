-- VIMRC
vim.cmd.packadd('cfilter')
vim.cmd.packadd('nvim.undotree')
vim.cmd.packadd('nvim.difftool')

require('vim._core.ui2').enable()

vim.cmd.colorscheme('habamax')
vim.cmd.colorscheme('default')

vim.g.mapleader = ' '
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = 'yes'
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.undofile = true
vim.o.confirm = true
vim.opt.path:append { '**' }

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set({ 'n', 'x' }, '<leader>y', '"+y')

vim.keymap.set('n', '<leader>e', '<cmd>Explore<CR>')

vim.keymap.set('n', '<leader>.', '<cmd>browse oldfiles<CR>')

vim.keymap.set('n', '<leader>f', ':find ')
vim.keymap.set('n', '<leader>b', ':buffer ')
vim.keymap.set('n', '<leader>/', ':copen | :silent grep! ')
vim.keymap.set('n', '<leader>w', ':copen | :silent grep! <C-r><C-w><CR>')

vim.keymap.set('n', '<leader>t', ':terminal<CR>a')

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function() vim.highlight.on_yank() end,
})
