return {
    --cmd = { 'lua-language-server' },
    cmd = { vim.fn.stdpath('data') .. '/mason/bin/' .. 'ocamllsp' },
    filetypes = {
        "ocaml",
        "ocaml.interface",
        "ocaml.menhir",
        "ocaml.cram",
        "ocaml.mlx",
        "ocaml.ocamllex",
        "reason",
    },
    settings = {
        codelens = { enable = true },
        inlayHints = { enable = true },
        syntaxDocumentation = { enable = true },
    },
}

