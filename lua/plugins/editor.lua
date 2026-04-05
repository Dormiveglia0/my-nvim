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
  -- 🌟 新增的强大工具插件
  -- ==========================================
  
  -- 1. 模糊搜索神器 Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
    },
  },

  -- 2. 快捷键提示面板 Which-key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup()
    end
  },

  -- 3. 视线级光标跳转 Flash
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
