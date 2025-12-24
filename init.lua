vim.cmd([[set mouse=]])          -- mouse is for the weak

vim.opt.guicursor = "a:blinkon0" -- no blink
vim.opt.winborder = "single"

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"

vim.opt.tabstop = 4        -- A TAB character looks like 4 spaces
vim.opt.expandtab = true   -- Pressing the TAB key will insert spaces instead of a TAB character
vim.opt.softtabstop = 4    -- Number of spaces inserted instead of a TAB character
vim.opt.shiftwidth = 4     -- Number of spaces inserted when indenting
vim.opt.smartindent = true -- syntax aware indentations for newline inserts
vim.opt.list = true        -- Shows > and - for tabs and trailing spaces

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "split"

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.cursorline = true   -- Horizontal cursor line
vim.opt.cursorcolumn = true -- Vertical cursor line

-- vim.o.completeopt = "o,.,w,b,u,t"
vim.o.completeopt = "fuzzy,menuone,noselect,popup"

vim.filetype.plugin = "on"

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>o", ":update<CR> :source<CR>")
-- in visual mode, use J and K to move a selected up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- brings line below current to current line
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz") -- center screen
vim.keymap.set("n", "<C-u>", "<C-u>zz") -- center screen
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set({ "n", "v", "x" }, "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')
vim.keymap.set({ "n", "v", "x" }, "<leader>P", '"+p')
vim.keymap.set({ "n", "v", "x" }, "<leader>d", '"_d')

vim.keymap.set("i", "<C-c>", "<ESC>")
vim.keymap.set("t", "", "") -- map esc to always return to normal mode
vim.keymap.set("t", "", "") -- don't move cursor when <C-o> is done

-- -----------------------------------------------------
-- Plugin manager
-- -----------------------------------------------------
vim.api.nvim_create_autocmd({ "PackChanged" }, {
    callback = function(ev)
        local data = ev.data
        local plugin_name = data.spec.name
        local plugin_path = data.path
        if plugin_name == "LuaSnip" and data.kind == "install" then
            os.execute(string.format("make -C %s install_jsregexp", plugin_path))
            return
        end
        if plugin_name == "nvim-treesitter" then
            vim.cmd([[TSUpdate]])
        end
    end
})

vim.pack.add({
    -- { src = "https://github.com/chomosuke/typst-preview.nvim" },
    -- { src = "https://github.com/uhs-robert/sshfs.nvim" }, -- cool fs mount over ssh

    -- Snippets
    { src = "https://github.com/L3MON4D3/LuaSnip" },

    -- Navigation
    { src = "https://github.com/ThePrimeagen/harpoon",            version = "harpoon2", },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
    { src = "https://github.com/stevearc/oil.nvim" },

    -- LSP and formatting
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/stevearc/conform.nvim", },

    -- Color theme
    { src = "https://github.com/blazkowolf/gruber-darker.nvim", },

    -- General deps
    { src = "https://github.com/nvim-telescope/telescope.nvim" }, -- Dep for neogit
    { src = "https://github.com/nvim-lua/plenary.nvim" },         -- Dep for harpoon, neogit
    { src = "https://github.com/MunifTanjim/nui.nvim" },          -- Dep for hunk

    -- VCS
    { src = "https://github.com/sindrets/diffview.nvim.git" }, -- Dep for neogit (optional)
    { src = "https://github.com/NeogitOrg/neogit.git" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/julienvincent/hunk.nvim", },
})

local update_plugins = function()
    local installed = vim.pack.get()
    local names = {}
    for _, v in ipairs(installed) do
        table.insert(names, v.spec.name)
    end
    vim.pack.update(names)
end
vim.api.nvim_create_user_command("UpdatePlugins", update_plugins,
    { desc = "Update plugins installed using built-in package manager" })

local pack_clean = function()
    local active_plugins = {}
    local unused_plugins = {}

    for _, plugin in ipairs(vim.pack.get()) do
        active_plugins[plugin.spec.name] = plugin.active
    end

    for _, plugin in ipairs(vim.pack.get()) do
        if not active_plugins[plugin.spec.name] then
            table.insert(unused_plugins, plugin.spec.name)
        end
    end

    if #unused_plugins == 0 then
        print("No unused plugins.")
        return
    end

    local choice = vim.fn.confirm("Remove unused plugins?", "&Yes\n&No", 2)
    if choice == 1 then
        vim.pack.del(unused_plugins)
    end
end
vim.api.nvim_create_user_command("CleanPlugins", pack_clean,
    { desc = "Clean plugins installed using built-in package manager" })

-- -----------------------------------------------------
-- Git and jj
-- -----------------------------------------------------
vim.api.nvim_create_user_command("DiffEditor", function()
    require("hunk").setup()
end, {})
require("gitsigns").setup()
require("neogit").setup({})
vim.keymap.set("n", "<leader>gs", function() require("neogit").open() end, { silent = true, desc = "Neogit" })

-- -----------------------------------------------------
-- LSP and formatting
-- -----------------------------------------------------
require("mason").setup({})
-- vim.cmd([[MasonInstall clangd clang-format emmylua_ls lua-language-server pyright ruff rust-analyzer gopls ]])
require("conform").setup({
    format_on_save = nil,
    formatters_by_ft = {
        c = { "clang-format", lsp_format = "fallback" },
        cpp = { "clang-format", lsp_format = "fallback" },
        lua = { "emmylua_ls", "stylua", lsp_format = "fallback" },
        python = { "black", lsp_format = "fallback" },
        rust = { "rustfmt", lsp_format = "fallback" },
    },
})
vim.keymap.set("n", "<leader>bf", function() require("conform").format() end)
vim.lsp.enable({
    "autotools_ls",
    "bashls",
    "clangd",
    "emmylua_ls",
    "lua_ls",
    "marksman", -- musl support problems
    -- "pyright",
    "ruff",
    -- "svls",
    -- "veridian",
    "zls",
    "tinymist",
    "rust_analyzer",
    "gopls",
})

local virtual_text_enabled = false
vim.keymap.set("n", "<leader>ll", function()
    virtual_text_enabled = not virtual_text_enabled
    vim.diagnostic.config({ virtual_text = virtual_text_enabled })
end, {})

-- -----------------------------------------------------
-- Treesitter
-- -----------------------------------------------------
vim.api.nvim_create_autocmd('FileType', {
    pattern = { '<filetype>' },
    callback = function()
        vim.treesitter.start()
        vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo[0][0].foldmethod = 'expr'
    end,
})

-- -----------------------------------------------------
-- Oil and harpoon
-- -----------------------------------------------------
require("oil").setup({
    columns = {
        -- "icon",
        "permissions",
        "size",
        -- "mtime",
    },
    view_options = {
        show_hidden = true,
    },
})
vim.keymap.set("n", "<leader>pv", "<CMD>Oil<CR>")

local harpoon = require("harpoon")
harpoon:setup()
vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Add to harpoon" })
vim.keymap.set("n", "<leader>e", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Toogle harpoon" })
for _, idx in ipairs({ 1, 2, 3, 4, 5 }) do
    vim.keymap.set("n", string.format("<leader>%d", idx), function()
        harpoon:list():select(idx)
    end)
end
local harpoon_extensions = require("harpoon.extensions")
harpoon:extend(harpoon_extensions.builtins.highlight_current_file())

-- -----------------------------------------------------
-- Colorscheme
-- -----------------------------------------------------
require("gruber-darker").setup({
    bold = true,
    invert = {
        signs = false,
        tabline = false,
        visual = false,
    },
    italic = {
        strings = false,
        comments = true,
        operators = false,
        folds = false,
    },
    undercurl = true,
    underline = true,
})
vim.cmd("colorscheme gruber-darker")

-- -----------------------------------------------------
-- Telescope
-- -----------------------------------------------------
require('telescope').setup({
    defaults = {
        theme = "ivy",
    },
    pickers = {
        find_files = { theme = "ivy", },
        live_grep = { theme = "ivy", },
        buffers = { theme = "ivy", },
        help_tags = { theme = "ivy", },
        man_pages = { theme = "ivy", },
    },
})

local builtin = require('telescope.builtin')
local ivy = require('telescope.themes').get_dropdown({});
vim.keymap.set('n', '<leader>fd', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>fm', builtin.man_pages, { desc = 'Telescope man pages' })


-- -----------------------------------------------------
-- LuaSnip
-- -----------------------------------------------------
require("luasnip").setup({ enable_autosnippets = true })
require("luasnip.loaders.from_lua").load({ paths = vim.fn.stdpath("config") .. "/snippets" })
local ls = require("luasnip")
vim.keymap.set({ "i", "s" }, "<C-e>", function() ls.expand_or_jump(1) end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-J>", function() ls.jump(1) end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-K>", function() ls.jump(-1) end, { silent = true })

-- -----------------------------------------------------
-- Statusline
-- -----------------------------------------------------
---Show attached LSP clients in `[name1, name2]` format.
---Long server names will be modified. For example, `lua-language-server` will be shorten to `lua-ls`
---Returns an empty string if there aren't any attached LSP clients.
---@return string
local function lsp_status()
    local attached_clients = vim.lsp.get_clients({ bufnr = 0 })
    if #attached_clients == 0 then
        return ""
    end
    local names = vim.iter(attached_clients)
        :map(function(client)
            local name = client.name:gsub("language.server", "ls")
            return name
        end)
        :totable()
    return "[" .. table.concat(names, ", ") .. "]"
end

function _G.statusline()
    return table.concat({
        "%f",
        "%h%w%m%r",
        "%=",
        lsp_status(),
        " %-14(%l,%c%V%)",
        "%P",
    }, " ")
end

vim.o.statusline = "%{%v:lua._G.statusline()%}"

-- -----------------------------------------------------
-- Other files
-- -----------------------------------------------------
require("config.autocmds")

-- -----------------------------------------------------
-- Neovide specific config
-- -----------------------------------------------------
if vim.g.neovide then
    vim.o.guifont = "CaskaydiaCove Nerd Font:h10"
    vim.g.neovide_cursor_animation_length = 0
    vim.g.neovide_cursor_animate_in_insert_mode = false
    vim.g.neovide_cursor_animate_command_line = false
    vim.g.neovide_scroll_animation_far_lines = 0
    vim.g.neovide_scroll_animation_length = 0
end
