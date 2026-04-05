return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("plugin_configs.lsp")
    end
  },

  -- ==========================================
  -- 🌟 核心替换：Blink.cmp (替代 nvim-cmp)
  -- ==========================================
  {
    'saghen/blink.cmp',
    dependencies = {
      'rafamadriz/friendly-snippets',
      -- 移除了 LuaSnip，Blink 内置了极速的 snippet 引擎
    },
    version = '*',
    opts = {
      -- 快捷键映射 (类似你之前的配置)
      keymap = {
        preset = 'default',
        ['<CR>'] = { 'accept', 'fallback' },
        ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
        ['<C-e>'] = { 'cancel', 'fallback' },
      },
      
      -- UI 外观配置
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
      },
      
      -- 补全来源配置
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },

      -- 签名帮助 (写函数时提示参数)
      signature = { enabled = true }
    },
    opts_extend = { "sources.default" }
  },

  {
    "numToStr/Comment.nvim",
    config = function()
      require("plugin_configs.comment")
    end
  },

  {
    "windwp/nvim-autopairs",
    config = function()
      require("plugin_configs.autopairs")
    end
  },

  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("conform").setup({
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
        formatters_by_ft = {
          lua = { "stylua" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          cpp = { "clang-format" },
          c = { "clang-format" },
        },
      })
    end,
  },
}
