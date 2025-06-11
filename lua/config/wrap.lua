vim.keymap.set({ "v", "n" }, "<C-j>", "gj", {})
vim.keymap.set({ "v", "n" }, "<C-k>", "gk", {})
vim.keymap.set({ "v", "n" }, "<C-4>", "g$", {})
vim.keymap.set({ "v", "n" }, "<C-6>", "g^", {})
vim.keymap.set({ "v", "n" }, "<C-0>", "g0", {})

local callback = function(args)
	if args.bang == false then
		vim.cmp("set spell wrap linebreak nolist")
	else
		vim.cmp("set nospell nowrap nolinebreak list")
	end
end

vim.api.nvim_create_user_command("Wrap", callback, {
	nargs = 0,
	desc = "Sets some options for editing text",
	bang = true,
})
