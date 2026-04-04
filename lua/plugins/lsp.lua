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
		"vtsls", "cssls", "html", "clangd"
	},
	automatic_installation = true,
})

-- 使用 setup_handlers 自动配置所有由 mason 安装的 LSP
require("mason-lspconfig").setup_handlers({
    -- 默认处理程序：为所有服务器自动应用 capabilities
    function(server_name)
        local status_ok, lspconfig = pcall(require, "lspconfig")
        if status_ok and lspconfig[server_name] then
            lspconfig[server_name].setup({
                capabilities = capabilities
            })
        end
    end,
    
    -- 针对 clangd 的特殊配置覆盖
    ["clangd"] = function()
        local status_ok, lspconfig = pcall(require, "lspconfig")
        if status_ok then
            lspconfig.clangd.setup({
                capabilities = vim.tbl_deep_extend("force", capabilities, {
                    offsetEncoding = { "utf-8", "utf-16" },
                    textDocument = {
                        completion = {
                            editsNearCursor = true
                        }
                    }
                }),
                cmd = { "clangd-18" },
                filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
                root_dir = lspconfig.util.root_pattern("compile_commands.json", ".git"),
                single_file_support = true,
            })
        end
    end,
})
