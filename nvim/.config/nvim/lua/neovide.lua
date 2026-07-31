if vim.g.neovide then
  vim.o.guifont = "Hurmit Nerd Font:h14"

	vim.keymap.set('n', '<C-s-v>', '"+p')
	vim.keymap.set('i', '<C-s-v>', '<C-r>+')
	vim.keymap.set('t', '<C-s-v>', '<C-\\><C-o>"+p')
end

