---@type vim.lsp.Config
return {
    cmd = { vim.fn.stdpath("data") .. "/mason/bin/" .. "gopls" },
    filetypes = { "go", "gomod", "gosum" },
    root_markers = {
        "go.mod",
        "go.sum",
    },
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
                fieldalignment = true,
                inferTypeArgs = true,
            },
            hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
            },
            staticcheck = true,
            gofumpt = true,
            semanticTokens = true,
        },
    },
}
