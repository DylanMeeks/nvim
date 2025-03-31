-- in visual mode, use J and K to move a selected up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- brings line below current to current line
vim.keymap.set("n", "J", "mzJ`z")

-- <C-d>, <C-u>, n, and N now also center the screen
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- vim.keymap.set("n", "<leader>vwm", function() require("vim.with.me").StartVimWithMe() end)
-- vim.keymap.set("n", "<leader>svwm", function() require("vim.with.me").StopVimWithMe() end)

-- greatest remap ever
vim.keymap.set("x", "<leader>p", '"_dP')

-- leader y to add to system clipboard
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

-- leader d to delete but don't copy to register
vim.keymap.set("v", "<leader>d", '"_d')
vim.keymap.set("n", "<leader>d", '"_d')

vim.keymap.set("i", "<C-c>", "<ESC>")

vim.keymap.set("n", "Q", "<nop>")
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tms switch<CR>")
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tms switch<CR>")

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Enter Explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Sorce current file
vim.keymap.set("n", "<leader><leader>", function()
	vim.cmd("so")
end)
