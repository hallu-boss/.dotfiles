vim.pack.add {
	'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/stevearc/oil.nvim',
  'https://github.com/tpope/vim-fugitive',
}

vim.cmd.colorscheme('habamax')
vim.cmd.colorscheme('default')

vim.cmd.packadd('cfilter')
vim.cmd.packadd('nvim.undotree')
vim.cmd.packadd('nvim.difftool')

require('vim._core.ui2').enable()

-- NEOVIDE
if vim.g.neovide then
  vim.o.guifont = "CommitMono Nerd Font:h14"

	vim.keymap.set('n', '<C-s-v>', '"+p')
	vim.keymap.set('i', '<C-s-v>', '<C-r>+')
	vim.keymap.set('t', '<C-s-v>', '<C-\\><C-o>"+p')
end


require('oil').setup()

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
vim.opt.completeopt = 'menu,menuone,fuzzy,noinsert'
vim.opt.statusline = "%<%f %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%) %P"

function rg_find_files(cmdarg, _)
  local fnames = vim.fn.systemlist("rg --files --hidden --color=never ")
  if #cmdarg == 0 then
    return fnames
  else
    return vim.fn.matchfuzzy(fnames, cmdarg)
  end
end

vim.o.findfunc = "v:lua.rg_find_files"

-- KEYMAPS
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set({ 'n', 'x' }, '<leader>y', '"+y')
vim.keymap.set('n', '<leader>t', ':terminal<CR>a')

vim.keymap.set('n', '-', '<cmd>Oil<CR>')

vim.keymap.set('n', '<leader>.', '<cmd>browse oldfiles<CR>')
vim.keymap.set('n', '<leader>f', ':find ')
vim.keymap.set('n', '<leader>b', ':buffer ')
vim.keymap.set('n', '<leader>/', ':grep ')
vim.keymap.set('n', '<leader>w', ':grep <C-r><C-w><CR>')
vim.keymap.set('n', '<leader>g', '<cmd>tab G<CR>')

-- AUTOCOMMANDS
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function() vim.highlight.on_yank() end,
})

vim.api.nvim_create_autocmd('FileType', {
    callback = function() pcall(vim.treesitter.start) end,
})

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        vim.o.signcolumn = 'yes:1'
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        if client:supports_method('textDocument/completion') then
            vim.o.complete = 'o,.,w,b,u'
            vim.o.completeopt = 'menu,menuone,popup,noinsert'
            vim.lsp.completion.enable(true, client.id, args.buf)
        end
    end
})
