-- VIMRC
vim.pack.add {
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/mason-org/mason.nvim',
    'https://github.com/tpope/vim-fugitive',
}

vim.cmd.packadd('cfilter')
vim.cmd.packadd('nvim.undotree')
vim.cmd.packadd('nvim.difftool')

require('vim._core.ui2').enable()

require('mason').setup()
vim.lsp.enable { 'lua_ls', 'vtsls' }

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
vim.o.statusline = "%<%f %h%w%m%r%{FugitiveStatusline()} %{% v:lua.require('vim._core.util').term_exitcode() %}%=%{% luaeval('(package.loaded[''vim.ui''] and vim.api.nvim_get_current_win() == tonumber(vim.g.actual_curwin or -1) and vim.ui.progress_status()) or '''' ')%}%{% &showcmdloc == 'statusline' ? '%-10.S ' : '' %}%{% exists('b:keymap_name') ? '<'..b:keymap_name..'> ' : '' %}%{% &busy > 0 ? '◐ ' : '' %}%{% luaeval('(package.loaded[''vim.diagnostic''] and next(vim.diagnostic.count()) and vim.diagnostic.status() .. '' '') or '''' ') %}%{% &ruler ? ( &rulerformat == '' ? '%-14.(%l,%c%V%) %P' : &rulerformat ) : '' %}"

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set({ 'n', 'x' }, '<leader>y', '"+y')

vim.keymap.set('n', '<leader>e', '<cmd>Explore<CR>')

vim.keymap.set('n', '<leader>.', '<cmd>browse oldfiles<CR>')

vim.keymap.set('n', '<leader>f', ':find ')
vim.keymap.set('n', '<leader>b', ':buffer ')
vim.keymap.set('n', '<leader>/', ':copen | :silent grep! ')
vim.keymap.set('n', '<leader>w', ':copen | :silent grep! <C-r><C-w><CR>')
vim.keymap.set('n', '<leader>g', '<cmd>tab Git<CR>')

vim.keymap.set('n', '<leader>t', ':terminal<CR>a')

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function() vim.highlight.on_yank() end,
})
