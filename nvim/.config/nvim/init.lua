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
vim.o.wildmode = 'noselect'
vim.o.winborder = 'rounded'
vim.opt.wildoptions:append { 'fuzzy' }

vim.pack.add {
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/vague-theme/vague.nvim',
}

require('mason').setup()
vim.lsp.enable {
  'lua_ls'
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

vim.cmd.colorscheme('vague')

vim.keymap.set({ 'n', 'x' }, '<leader>y', '"+y')
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<leader>e', '<cmd>Ex<CR>')

vim.keymap.set('n', '<leader>f', ':find ')
vim.keymap.set('n', '<leader>b', ':buffer ')
vim.keymap.set('n', '<leader>/', ':copen | silent grep! ')
vim.keymap.set('n', '<leader>w', ':copen | silent grep! <C-r><C-w><CR>')
vim.keymap.set('n', '<leader>.', ':browse oldfiles<CR>')

vim.keymap.set('n', '<leader>v', '<cmd>edit $MYVIMRC<CR>')

vim.keymap.set('n', '<leader>g', '<cmd>terminal lazygit<CR>a')

vim.keymap.set('n', '<leader>t', '<cmd>terminal<CR>a')

vim.keymap.set('n', '<leader>h', function() require("gitsigns").setqflist("all") end)
vim.keymap.set('n', '[c', function() require("gitsigns").nav_hunk('prev') end)
vim.keymap.set('n', ']c', function() require("gitsigns").nav_hunk('next') end)

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

vim.api.nvim_create_autocmd('FileType', {
  callback = function() pcall(vim.treesitter.start) end,
})

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
