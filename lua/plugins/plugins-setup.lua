-- ==============================================
-- [核心] 1. 自动安装 lazy.nvim 插件管理器
-- ==============================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", -- [修正] 移除了会导致 git clone 失败的尖括号
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
        transparent_background = true, -- [修正] 修复了 `transparent_background` 的转义字符
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
  "nvim-lualine/lualine.nvim",                 -- 状态栏
  "nvim-tree/nvim-tree.lua",                   -- 侧边栏文档树
  "nvim-tree/nvim-web-devicons",               -- 文档树图标支持
  "christoomey/vim-tmux-navigator",            -- 使用 Ctrl-hjkl 无缝穿梭分屏

  -- ==========================================
  -- 🌳 语法高亮与渲染引擎 (Treesitter 系)
  -- ==========================================
  {
	"nvim-treesitter/nvim-treesitter",
    build = ':TSUpdate',
    -- [关键修正] 使用 pcall 安全加载模块，彻底杜绝首次安装时的缓存寻址报错
    config = function()
      local status_ok, configs = pcall(require, "nvim-treesitter.configs")
      if not status_ok then
        vim.notify("treesitter/nvim-treesitter: 'configs' module not found, skipping setup.", vim.log.levels.WARN)
        return
      end
      -- 在这里，我们可以 100% 确定 configs 模块已经被安全地加载了
      configs.setup({
        ensure_installed = { 
            "vim", "vimdoc", "bash", "c", "cpp", "javascript", 
            "json", "lua", "python", "typescript","css", "rust", 
            "markdown", "markdown_inline" 
        },
        highlight = { enable = true },
        indent = { enable = true },
        -- 别忘了这一句，我看到你的原配置里有，但之前的版本里我们漏掉了
        auto_install = true,
      })
    end,
  },
  'HiPhish/rainbow-delimiters.nvim',           -- 新一代彩虹括号，性能更佳

  -- ==========================================
  -- 🧠 LSP 语言服务器与自动补全引擎 (IDE 大脑)
  -- ==========================================
  {
    "williamboman/mason.nvim",                   -- LSP/DAP/Linter 等的自动安装包管理器
    "williamboman/mason-lspconfig.nvim",         -- 连接 mason 与 lspconfig 的桥梁
    "neovim/nvim-lspconfig"                      -- Neovim 官方 LSP 配置集合
  },

  -- 代码与命令自动补全插件核心
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",                      -- 补全来源：LSP
  "hrsh7th/cmp-cmdline",                       -- 补全来源：底部命令行

  -- 代码片段 Snippets 引擎 (若缺少这三行，cmp 补全将不完整)
  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip",                  -- [修正] 修复了转义字符
  "rafamadriz/friendly-snippets",              -- 预设的常用代码片段库
  "hrsh7th/cmp-path",                          -- 补全来源：文件路径

  -- ==========================================
  -- 🚀 高效代码编写助手
  -- ==========================================
  "numToStr/Comment.nvim",                     -- 快速注释 (gcc/gc)
  "windwp/nvim-autopairs",                     -- 自动补全另一半括号
  "akinsho/bufferline.nvim",                   -- 顶部文件标签页
  { 'akinsho/toggleterm.nvim', version = "*", config = true }, -- [修正] 修复了转义字符 | 一键唤出悬浮终端

  -- ==========================================
  -- 🪄 视觉与交互美化 (Modern UI)
  -- ==========================================
  { "sphamba/smear-cursor.nvim" },             -- 超丝滑的光标残影拖尾特效

  { -- 浮动命令行与美化通知
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" }
  },

  { -- 酷炫的启动欢迎界面
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  { -- 实时 Markdown 预览
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" },
  },

  { -- 代码缩进对齐线
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "BufReadPre"                       --  [修正] 修复了行尾多余的转义字符
  },

  -- ==========================================
  -- 🗺️ 代码结构导航与版本控制
  -- ==========================================
  { -- 代码大纲导航 (类似 VSCode 的 Outline)
    "stevearc/aerial.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  },

  { -- Git 状态高亮 (在行号旁显示增删改)
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre"                       --  [修正] 修复了行尾多余的转义字符
  },
}

-- ==============================================
-- [核心] 3. 启动 lazy.nvim 引擎
-- ==============================================
local opts = {}
require("lazy").setup(plugins, opts)
