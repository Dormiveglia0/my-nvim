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
	-- 🌟 新增的专业格式化工具 Conform
	-- ==========================================
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("conform").setup({
				format_on_save = {
					timeout_ms = 500,
					-- 这里的 lsp_fallback = true 完美解决了你的顾虑：
					-- 如果找不到专门的格式化工具，它会自动回退使用 LSP 进行格式化！
					lsp_fallback = true,
				},
				formatters_by_ft = {
					lua = { "stylua" },
					javascript = { "prettierd" },
					typescript = { "prettierd" },
					javascriptreact = { "prettierd" },
					typescriptreact = { "prettierd" },
					vue = { "prettierd" },
					css = { "prettierd" },
					html = { "prettierd" },
					json = { "prettierd" },
					markdown = { "prettierd" },
					cpp = { "clang-format" },
					c = { "clang-format" },
				},
			})
		end,
	},
}
