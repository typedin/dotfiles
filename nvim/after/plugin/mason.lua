require("mason").setup {
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
        },
    },
}

require("mason-lspconfig").setup {
    automatic_installation = true,
    ensure_installed = {
        "bashls",
        "efm",
        "emmet_ls",
        "eslint",
        "html",
        "jsonls",
        "marksman",
        "phpactor",
        "prismals",
        "sumneko_lua",
        "tailwindcss",
        "tsserver",
        "vimls",
        "volar",
    },
}
