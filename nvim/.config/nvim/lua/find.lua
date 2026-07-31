function rg_find_files(cmdarg, _cmdcomplete)
	local fnames = vim.fn.systemlist("rg --files --hidden --color=never ")
	if #cmdarg == 0 then
		return fnames
	else
		return vim.fn.matchfuzzy(fnames, cmdarg)
	end
end

vim.o.findfunc = "v:lua.rg_find_files"

