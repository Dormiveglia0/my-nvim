-- ==============================================
-- [核心] 1. 自动安装 lazy.nvim 插件管理器
-- ==============================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ==============================================
-- [核心] 2. 插件注册表
-- ==============================================
local plugins = {
  -- ==========================================
  -- 🎨 核心主题：融合了你的 Catppuccin 透明风
  -- ==========================================
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "frappe",
        transparent_background = true,
        custom_highlights = function(colors)
          return {
            LineNr = { fg = colors.text },
            CursorLineNr = { fg = colors.mauve, style = { "bold" } },
          }
        end
      })
      vim.cmd.colorscheme("catppuccin")
    end
  },

  -- ==========================================
  -- 🧰 基础 UI 与文件管理
  -- ==========================================
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("plugins.lualine")
    end
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("plugins.nvim-tree")
    end
  },
  "christoomey/vim-tmux-navigator",

  -- ==========================================
  -- 🌳 语法高亮与渲染引擎 (Treesitter 系)
  -- ==========================================
  {
    "nvim-treesitter/nvim-treesitter",
    build = ':TSUpdate',
    config = function()
      local status_ok, configs = pcall(require, "nvim-treesitter.configs")
      if not status_ok then
        vim.notify("treesitter/nvim-treesitter: 'configs' module not found, skipping setup.", vim.log.levels.WARN)
        return
      end
      configs.setup({
        ensure_installed = { 
            "vim", "vimdoc", "bash", "c", "cpp", "javascript", 
            "json", "lua", "python", "typescript","css", "rust", 
            "markdown", "markdown_inline" 
        },
        highlight = { enable = true },
        indent = { enable = true },
        auto_install = true,
      })
    end,
  },
  'HiPhish/rainbow-delimiters.nvim',

  -- ==========================================
  -- 🧠 LSP 语言服务器与自动补全引擎 (IDE 大脑)
  -- ==========================================
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("plugins.lsp")
    end
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      "hrsh7th/cmp-path",
    },
    config = function()
      require("plugins.cmp")
    end
  },

  -- ==========================================
  -- 🚀 高效代码编写助手
  -- ==========================================
  {
    "numToStr/Comment.nvim",
    config = function()
      require("plugins.comment")
    end
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("plugins.autopairs")
    end
  },
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("plugins.bufferline")
    end
  },
  { 
    'akinsho/toggleterm.nvim', 
    version = "*", 
    config = function()
      require("plugins.toggleterm")
    end
  },

  -- ==========================================
  -- 🪄 视觉与交互美化 (Modern UI)
  -- ==========================================
  { 
    "sphamba/smear-cursor.nvim",
    config = function()
      require("plugins.smear-cursor")
    end
  },

  { 
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
    config = function()
      require("plugins.noice")
    end
  },

  { 
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("plugins.dashboard")
    end
  },

  { 
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" },
    config = function()
      require("plugins.render-markdown")
    end
  },

  { 
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "BufReadPre",
    config = function()
      require("plugins.indent-blankline")
    end
  },

  -- ==========================================
  -- 🗺️ 代码结构导航与版本控制
  -- ==========================================
  { 
    "stevearc/aerial.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    config = function()
      require("plugins.aerial")
    end
  },

  { 
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    config = function()
      require("plugins.gitsigns")
    end
  },
}

-- ==============================================
-- [核心] 3. 启动 lazy.nvim 引擎
-- ==============================================
local opts = {}
require("lazy").setup(plugins, opts)
