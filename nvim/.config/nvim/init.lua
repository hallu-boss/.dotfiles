require('vim._core.ui2').enable()

vim.g.mapleader = ' '
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = 'yes'
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.expandtab = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.confirm = true
vim.o.wildmode = 'noselect'
vim.opt.wildoptions:append { 'fuzzy' }

vim.pack.add {
  'https://github.com/vague-theme/vague.nvim',
  'https://github.com/ibhagwan/fzf-lua',
}

vim.cmd.colorscheme('vague')
vim.api.nvim_set_hl(0, "FzfLuaBorder", { link = "BlinkCmpMenuBorder" })

vim.keymap.set({ 'n', 'x' }, '<leader>y', '"+y')
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<leader>e', '<cmd>Ex<CR>')

vim.keymap.set('n', '<leader>f', '<cmd>FzfLua files<CR>')
vim.keymap.set('n', '<leader>b', '<cmd>FzfLua buffers<CR>')
vim.keymap.set('n', '<leader>/', '<cmd>FzfLua live_grep<CR>')
vim.keymap.set('n', '<leader>j', '<cmd>FzfLua jumps<CR>')
vim.keymap.set('n', '<leader>\'', '<cmd>FzfLua resume<CR>')
vim.keymap.set('n', '<leader>?', '<cmd>FzfLua helptags<CR>')
vim.keymap.set('n', '<leader>k', '<cmd>FzfLua keymaps<CR>')
vim.keymap.set('n', '<leader>w', '<cmd>FzfLua grep_cword<CR>')
vim.keymap.set('x', '<leader>w', '<cmd>FzfLua grep_visual<CR>')
vim.keymap.set('n', '<leader>h', '<cmd>FzfLua git_hunks<CR>')
vim.keymap.set('n', '<leader>d', '<cmd>FzfLua diagnostics_document<CR>')

vim.keymap.set('n', '<leader>v', '<cmd>edit $MYVIMRC<CR>')

vim.keymap.set('n', '<leader>g', '<cmd>terminal lazygit<CR>a')

vim.keymap.set('n', '<leader>t', '<cmd>terminal<CR>a')

vim.api.nvim_create_autocmd('CmdlineChanged', {
  pattern = ':',
  callback = function()
    vim.fn.wildtrigger()
  end,
})

vim.api.nvim_create_autocmd('TermClose', {
  pattern = 'term://*lazygit',
  callback = function()
    vim.api.nvim_input('<CR>')
  end,
})
