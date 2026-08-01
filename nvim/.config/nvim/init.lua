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
require('mini.files').setup()
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

