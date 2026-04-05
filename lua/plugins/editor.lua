return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("plugin_configs.nvim-tree")
    end
  },

  "christoomey/vim-tmux-navigator",

  {
    "nvim-treesitter/nvim-treesitter",
    build = ':TSUpdate',
    config = function()
      local status_ok, configs = pcall(require, "nvim-treesitter.configs")
      if not status_ok then return end
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

  { 
    'akinsho/toggleterm.nvim', 
    version = "*", 
    config = function()
      require("plugin_configs.toggleterm")
    end
  },

  { 
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" },
    config = function()
      require("plugin_configs.render-markdown")
    end
  },

  { 
    "stevearc/aerial.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    config = function()
      require("plugin_configs.aerial")
    end
  },

  { 
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    config = function()
      require("plugin_configs.gitsigns")
    end
  },

  -- ==========================================
  -- 🌟 新增：Snacks.nvim (替代 Telescope, Dashboard, Noice 等)
  -- ==========================================
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      -- 开启大屏启动页 (替代 dashboard-nvim)
      dashboard = { enabled = true },
      -- 开启通知系统 (替代 nvim-notify 和 noice 的通知部分)
      notifier = { enabled = true, timeout = 3000 },
      -- 开启极其快速的模糊搜索 (替代 telescope)
      picker = { enabled = true },
      -- 开启平滑滚动
      scroll = { enabled = true },
      -- 开启终端管理
      terminal = { enabled = true },
      -- 开启快捷键提示面板 (替代 which-key)
      words = { enabled = true },
      -- 开启懒加载优化
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
    },
    keys = {
      -- 搜索相关
      { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
      { "<leader>fg", function() Snacks.picker.grep() end, desc = "Grep" },
      { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
      -- 通知历史
      { "<leader>n", function() Snacks.notifier.show_history() end, desc = "Notification History" },
      -- 终端
      { "<c-/>", function() Snacks.terminal() end, desc = "Toggle Terminal" },
    },
  },

  -- 2. 视线级光标跳转 Flash (依然保留，Snacks 还没有完全替代它)
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    },
  },
}
