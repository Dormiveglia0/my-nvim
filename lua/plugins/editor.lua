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
  -- 🌟 恢复 Which-key (Snacks.words 只是高亮相同单词，不能替代 which-key)
  -- ==========================================
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup()
    end
  },

  -- ==========================================
  -- 🌟 Snacks.nvim (替代 Telescope, Dashboard, Notify)
  -- ==========================================
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      dashboard = { enabled = true },
      notifier = { enabled = true, timeout = 3000 },
      picker = { enabled = true },
      scroll = { enabled = true },
      terminal = { enabled = true },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
    },
    keys = {
      { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
      { "<leader>fg", function() Snacks.picker.grep() end, desc = "Grep" },
      { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
      { "<leader>n", function() Snacks.notifier.show_history() end, desc = "Notification History" },
      { "<c-/>", function() Snacks.terminal() end, desc = "Toggle Terminal" },
    },
  },

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
