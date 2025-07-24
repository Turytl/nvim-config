-- top settings
vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46/"
vim.g.mapleader = " "
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldlevel = 99

-- bootstrap lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      local npairs = require("nvim-autopairs")
      npairs.setup({ check_ts = true })

      local Rule = require("nvim-autopairs.rule")
      npairs.add_rules({
        Rule("<", ">", { "lua", "javascript", "html", "typescript", "c", "cpp", "rust" }),
      })

      local cmp_ok, cmp = pcall(require, "cmp")
      if cmp_ok then
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
      end
    end
  },
  {
    "nomnivore/ollama.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
    {
      "<leader>oo",
      ":<c-u>lua require('ollama').prompt()<cr>",
      desc = "Ollama prompt",
      mode = { "n", "v" },
    },
    {
      "<leader>oG",
      ":<c-u>lua require('ollama').prompt('Generate_Code')<cr>",
      desc = "Ollama Generate Code",
      mode = { "n", "v" },
    },
    {
      "<leader>os",
      ":OllamaModel<cr>",
      desc = "Select Ollama Model",
      mode = { "n", "v" },
    },
  },
  opts = {
    model = "qwen2.5-coder:0.5b", -- sets your default model 
     },
  },	
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("ibl").setup({
        indent = { char = "│" },
        exclude = {
          filetypes = { "dashboard", "NvimTree" },
          buftypes = { "terminal" },
        },
        scope = { enabled = true },
      })
    end
  },
  {
    "mattn/emmet-vim",
    lazy = false,
  },
  {
    "NStefan002/screenkey.nvim",
    lazy = false,
    version = "*",
    config = function()
      vim.api.nvim_set_keymap("n", "<Leader>sk", ":Screenkey toggle<CR>", { noremap = true, silent = true, desc = "Toggle Screenkey" })
    end
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      local ls = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()
      vim.api.nvim_set_keymap("i", "<C-Y>", "<cmd>lua require('luasnip').expand_or_jump()<CR>", { noremap = true, silent = true })
    end
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    lazy = false,
    config = function()
      require("treesitter-context").setup()
    end
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "supermaven-inc/supermaven-nvim",
        opts = {
          disable_inline_completion = true,
        },
      },
      {
        "hrsh7th/cmp-cmdline",
        event = "CmdlineEnter",
        config = function()
          local cmp = require "cmp"

          cmp.setup.cmdline("/", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = { { name = "buffer" } },
          })

          cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources(
              { { name = "path" } },
              { { name = "cmdline" } }
            ),
            matching = { disallow_symbol_nonprefix_matching = false },
          })
        end,
      },
    },
  opts = function(_, opts)
    opts.sources[1].trigger_characters = { "-" }
    table.insert(opts.sources, 1, { name = "supermaven" })

    local cmp = require("cmp")

    opts.mapping = cmp.mapping.preset.insert({
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<CR>'] = cmp.mapping.confirm { select = false },
      ['<Tab>'] = cmp.mapping.select_next_item(),
      ['<S-Tab>'] = cmp.mapping.select_prev_item(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
    })
  end,
},
  { import = "plugins" },
}, lazy_config)

-- theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.cmd("Screenkey toggle")
  end,
})

vim.schedule(function()
  require "mappings"
end)
