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
vim.o.undofile = true
vim.o.list = true

vim.cmd.colorscheme('habamax')
vim.cmd.colorscheme('default')

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

require('mini.icons').setup()
require('mini.pick').setup()
require('mini.files').setup()
require('mini.diff').setup()
require('mini.git').setup()
require('mini.completion').setup()
require('mini.cmdline').setup()
require('mini.extra').setup()

vim.keymap.set({ 'n', 'x' }, '<leader>y', '"+y')
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('t', '<C-[>', '<C-\\><C-n>')
vim.keymap.set('t', '<Esc>', '<Esc>')

vim.keymap.set('n', '<leader>v', '<cmd>edit $MYVIMRC<CR>')

vim.keymap.set('n', '<leader>t', '<cmd>tab terminal<CR>a')

vim.keymap.set('n', '<leader>e', '<cmd>lua MiniFiles.open()<CR>')
vim.keymap.set('n', '<leader>E', '<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>')

vim.keymap.set('n', '<leader>f', '<cmd>Pick files<CR>')
vim.keymap.set('n', '<leader>b', '<cmd>Pick buffers<CR>')
vim.keymap.set('n', '<leader>?', '<cmd>Pick help<CR>')
vim.keymap.set('n', '<leader>k', '<cmd>Pick keymaps<CR>')
vim.keymap.set('n', '<leader>/', '<cmd>Pick grep_live<CR>')
vim.keymap.set('n', '<leader>\'', '<cmd>Pick resume<CR>')
vim.keymap.set('n', '<leader>h', '<cmd>Pick git_hunks<CR>')

vim.keymap.set('n', 'grr', '<cmd>Pick lsp scope="references"<CR>')
vim.keymap.set('n', 'gri', '<cmd>Pick lsp scope="implementation"<CR>')
vim.keymap.set('n', 'grt', '<cmd>Pick lsp scope="type_definition"<CR>')
vim.keymap.set('n', 'gO', '<cmd>Pick lsp scope="document_symbol"<CR>')
vim.keymap.set('n', 'gW', '<cmd>Pick lsp scope="workspace_symbol"<CR>')

vim.api.nvim_create_autocmd('FileType', {
  callback = function() pcall(vim.treesitter.start) end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function() vim.highlight.on_yank() end,
})

