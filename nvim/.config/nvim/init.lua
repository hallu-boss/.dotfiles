vim.g.mapleader = ' '
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = 'yes'
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.expandtab = true

vim.pack.add {
  'https://github.com/vague-theme/vague.nvim',
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-telescope/telescope.nvim',
  'https://github.com/nvim-telescope/telescope-ui-select.nvim',
  'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
  'https://github.com/nvim-telescope/telescope-file-browser.nvim',
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/kdheepak/lazygit.nvim',
}

vim.cmd.colorscheme('vague')

vim.g.lazygit_floating_window_scaling_factor = 0.96

require('telescope').setup({
  extensions = {
    ['ui-select'] = { require('telescope.themes').get_dropdown() },
    file_browser = { hijack_netrw = true },
  },
})

pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')
pcall(require('telescope').load_extension, 'file_browser')

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>e', function() require("telescope").extensions.file_browser.file_browser() end)
vim.keymap.set('n', '<leader>E', function() require("telescope").extensions.file_browser.file_browser({ path = vim.fs.dirname(vim.api.nvim_buf_get_name(0)) }) end)
vim.keymap.set('n', '<leader>f', builtin.find_files)
vim.keymap.set('n', '<leader>/', builtin.live_grep)
vim.keymap.set('n', '<leader>\'', builtin.resume)
vim.keymap.set('n', '<leader>?', builtin.help_tags)
vim.keymap.set('n', '<leader>k', builtin.keymaps)
vim.keymap.set({ 'n', 'x' }, '<leader>w', builtin.grep_string)

vim.keymap.set('n', '<leader>g', '<cmd>LazyGit<CR>')
vim.keymap.set('n', '<leader>G', '<cmd>LazyGitFilterCurrentFile<CR>')

vim.keymap.set('n', '<leader>t', '<cmd>terminal<CR>a')
