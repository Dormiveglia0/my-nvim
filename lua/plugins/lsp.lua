require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗"
		}
	}
})

require("mason-lspconfig").setup({
	ensure_installed = {
		-- "lua_ls"
	},
	automatic_installation = true,
})

-- require'lspconfig'.lua_ls.setup{
-- 	capabilities = capabilities
-- }

require'lspconfig'.vtsls.setup{
	capabilities = capabilities
}

require'lspconfig'.css_ls.setup{
	capabilities = capabilities
}

require'lspconfig'.vuels.setup{
	capabilities = capabilities
}

require'lspconfig'.html.setup{
	capabilities = capabilities
}
-- clangd configuration 
require'lspconfig'.clangd.setup{
	capabilities = {
		offsetEncoding = { "utf-8", "utf-16" },
		textDocument = {
			completion = {
				editsNearCursor = true
			}
		}
	},
	cmd = { "clangd-18" },
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
	root_dir = require'lspconfig'.util.root_pattern("compile_commands.json", ".git"),
	single_file_support = true,
}
