local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_nvim_lsp_status_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if cmp_nvim_lsp_status_ok then
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

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
		"vtsls", "cssls", "html", "clangd", "volar"
	},
	automatic_installation = true,
})

local lspconfig = require('lspconfig')

lspconfig.vtsls.setup{
	capabilities = capabilities
}

lspconfig.cssls.setup{
	capabilities = capabilities
}

lspconfig.volar.setup{
	capabilities = capabilities
}

lspconfig.html.setup{
	capabilities = capabilities
}

-- clangd configuration 
lspconfig.clangd.setup{
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
	root_dir = lspconfig.util.root_pattern("compile_commands.json", ".git"),
	single_file_support = true,
}
