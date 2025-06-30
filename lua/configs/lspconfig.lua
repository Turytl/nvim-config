require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "ts_ls", "pyright" }

require('lspconfig').emmet_ls.setup({
  filetypes = { "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact" },
})

require("lspconfig").pyright.setup{
  settings = {
    pyright = {
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        ignore = { "*" },
      },
    },
  },
}

require("lspconfig").ruff.setup({
  init_options = {
    settings = {
      -- cockeeper
      logLevel = "info",
      lint = {
        -- Enable linting.
        enable = true,
        run = "onType",
        select = {"E", "F", "B"},
        extendSelect = {"I"},
      },
      format = { preview = false },
    }
  }
})

vim.lsp.enable(servers)
