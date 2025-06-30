require "nvchad.mappings"

local map = vim.keymap.set
local diagnostic = vim.diagnostic
local lsp = vim.lsp.buf

-- Normal mode mappings
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>", { desc = "Escape insert mode" })

-- Diagnostics
map("n", "<space>e", diagnostic.open_float, { desc = "Open diagnostics float" })
map("n", "[d", diagnostic.goto_prev, { desc = "Prev Diagnostic" })
map("n", "]d", diagnostic.goto_next, { desc = "Next Diagnostic" })

-- LSP
map("n", "K", lsp.hover, { desc = "LSP: Hover" })
map("n", "gd", lsp.definition, { desc = "LSP: Go to Definition" })
map("n", "gD", lsp.declaration, { desc = "LSP: Go to Declaration" })
map("n", "gi", lsp.implementation, { desc = "LSP: Go to Implementation" })
map("n", "gr", lsp.references, { desc = "LSP: Go to References" })
map("n", "<leader>rn", lsp.rename, { desc = "LSP: Rename" })
map("n", "<leader>ca", lsp.code_action, { desc = "LSP: Code Action" })
map("n", "<leader>f", function() lsp.format({ async = true }) end, { desc = "LSP: Format" })
map("i", "<C-k>", lsp.signature_help, { desc = "LSP: Signature Help" })

-- Supermaven
map("i", "<C-l>", function() require("supermaven-nvim").accept_suggestion() end, { desc = "Supermaven: Accept Suggestion" })
map("i", "<C-]>", function() require("supermaven-nvim").clear_suggestion() end, { desc = "Supermaven: Clear Suggestion" })

-- DAP
map("n", "<leader>dt", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { desc = "Toggle breakpoint" })
map("n", "<leader>ds", "<cmd>lua require'dap'.continue()<CR>", { desc = "Start or continue debugging" })
map("n", "<leader>di", "<cmd>lua require'dap'.step_into()<CR>", { desc = "Step into" })
map("n", "<leader>do", "<cmd>lua require'dap'.step_over()<CR>", { desc = "Step over" })

-- NvimTree
map("n", "<leader>nt", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })
