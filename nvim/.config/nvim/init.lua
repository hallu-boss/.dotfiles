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
vim.o.list = true
vim.o.cursorline = true
vim.opt.wildoptions:append { 'fuzzy' }
vim.o.statusline = "%<%f %h%w%m%r %{get(b:,'gitsigns_head','')} %{% v:lua.require('vim._core.util').term_exitcode() %}%=%{% luaeval('(package.loaded[''vim.ui''] and vim.api.nvim_get_current_win() == tonumber(vim.g.actual_curwin or -1) and vim.ui.progress_status()) or '''' ')%}%{% &showcmdloc == 'statusline' ? '%-10.S ' : '' %}%{% exists('b:keymap_name') ? '<'..b:keymap_name..'> ' : '' %}%{% &busy > 0 ? '◐ ' : '' %}%{% luaeval('(package.loaded[''vim.diagnostic''] and next(vim.diagnostic.count()) and vim.diagnostic.status() .. '' '') or '''' ') %}%{% &ruler ? ( &rulerformat == '' ? '%-14.(%l,%c%V%) %P' : &rulerformat ) : '' %}"

vim.pack.add {
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/vague-theme/vague.nvim',
  'https://github.com/hedyhli/outline.nvim',
  'https://github.com/yorickpeterse/nvim-pqf',
}

require('outline').setup()
require('pqf').setup()

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

vim.cmd.colorscheme('vague')

vim.keymap.set({ 'n', 'x' }, '<leader>y', '"+y')
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('t', '<C-[>', '<C-\\><C-n>')
vim.keymap.set('t', '<Esc>', '<Esc>')

vim.keymap.set('n', '<leader>e', '<cmd>Ex<CR>')

vim.keymap.set('n', '<leader>f', ':find ')
vim.keymap.set('n', '<leader>b', ':buffer ')
vim.keymap.set('n', '<leader>/', ':copen | silent grep! ')
vim.keymap.set('n', '<leader>w', ':copen | silent grep! <C-r><C-w><CR>')
vim.keymap.set('n', '<leader>.', ':browse oldfiles<CR>')

vim.keymap.set('n', '<leader>s', vim.lsp.buf.document_symbol)
vim.keymap.set('n', '<leader>S', vim.lsp.buf.workspace_symbol)
vim.keymap.set('n', '<leader>d', vim.diagnostic.setqflist)

vim.keymap.set('n', '<leader>v', '<cmd>edit $MYVIMRC<CR>')

vim.keymap.set('n', '<leader>g', '<cmd>tab terminal lazygit<CR>a')

vim.keymap.set('n', '<leader>t', '<cmd>tab terminal<CR>a')

vim.keymap.set('n', '<leader>h', function() require("gitsigns").setqflist("all") end)
vim.keymap.set('n', '[c', function() require("gitsigns").nav_hunk('prev') end)
vim.keymap.set('n', ']c', function() require("gitsigns").nav_hunk('next') end)

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

vim.keymap.set('n', '<leader>o', '<cmd>Outline<CR>')

vim.api.nvim_create_autocmd('FileType', {
  callback = function() pcall(vim.treesitter.start) end,
})

vim.api.nvim_create_autocmd('CmdlineChanged', {
  pattern = ':',
  callback = function() vim.fn.wildtrigger() end,
})

vim.api.nvim_create_autocmd('TermClose', {
  pattern = 'term://*lazygit',
  callback = function() vim.api.nvim_input('<CR>') end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function() vim.highlight.on_yank() end,
})

