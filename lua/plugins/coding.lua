return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			require("plugin_configs.lsp")
		end,
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
			require("plugin_configs.cmp")
		end,
	},

	{
		"numToStr/Comment.nvim",
		config = function()
			require("plugin_configs.comment")
		end,
	},

	{
		"windwp/nvim-autopairs",
		config = function()
			require("plugin_configs.autopairs")
		end,
	},

	-- ==========================================
	-- 🌟 专业格式化工具 Conform (配合 mason-conform 实现零配置)
	-- ==========================================
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "zapling/mason-conform.nvim" }, -- 引入自动桥接插件
		config = function()
			require("conform").setup({
				format_on_save = {
					timeout_ms = 2500,
					lsp_fallback = true,
				},
				formatters_by_ft = {
					nginx = { "nginxfmt" },
				},
                -- 默认配置，即使没有指定 formatter，也会尝试使用 lsp_fallback
                -- 你可以在这里添加特定的 formatter，但 mason-conform 会自动处理大部分
			})

			-- 让 mason 自动把安装的工具注册给 conform
			require("mason-conform").setup()
		end,
	},
}
