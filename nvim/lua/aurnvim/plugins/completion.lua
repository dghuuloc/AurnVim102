return {
  "hrsh7th/nvim-cmp",
  --  event = "InsertEnter",
  dependencies = {
    --  'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    -- 'rafamadriz/friendly-snippets',
    'onsails/lspkind.nvim',

    -- [[ Plugins for luaSnip user ]]
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
  },

  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
    --  require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,preview,noselect",
      },

      --  snippet = { -- configure how nvim-cmp interacts with snippet engine
        --  expand = function(args)
          --  luasnip.lsp_expand(args.body)
        --  end,
      --  },

      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(),             -- previous suggestion
        ["<C-j>"] = cmp.mapping.select_next_item(),             -- next suggestion
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),                 -- show completion suggestions
        ["<C-e>"] = cmp.mapping.abort(),                        -- close completion window
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
      }),

      -- sources for autocompletion
      sources = cmp.config.sources({
        { name = "buffer" },
        { name = "nvim_lsp" },
        --  { name = "luasnip" },
        --  { name = "path" },
      }),

      -- configure lspkind for vs-code like pictograms in completion menu
      --  formatting = {
        --  format = lspkind.cmp_format({
          --  maxwidth = 100,
          --  ellipsis_char = "...",
        --  }),
      --  },
    })
  end,
}
