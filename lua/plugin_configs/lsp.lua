local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_nvim_lsp_status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_nvim_lsp_status_ok then
	capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

local mason_status_ok, mason = pcall(require, "mason")
if mason_status_ok then
	mason.setup({
		ui = {
			icons = { package_installed = "✓", package_pending = "➜", package_uninstalled = "✗" },
		},
	})
end

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then return end

local mason_lspconfig_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if mason_lspconfig_status_ok then
	mason_lspconfig.setup({
		-- 自动安装你想要的 LSP
		ensure_installed = { "clangd", "cssls", "html", "lua_ls", "pyright" },
		automatic_installation = true,
		handlers = {
			-- 默认的 handler，会自动为所有通过 mason 安装的 server 调用 setup
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
				})
			end,
			-- 你可以在这里保留特定语言的特殊配置，比如 clangd
			["clangd"] = function()
				lspconfig.clangd.setup({
					capabilities = vim.tbl_deep_extend("force", capabilities, { offsetEncoding = { "utf-8", "utf-16" } }),
					cmd = { "clangd" },
					filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
					root_dir = lspconfig.util.root_pattern("compile_commands.json", ".git"),
					single_file_support = true,
				})
			end,
            ["lua_ls"] = function()
                lspconfig.lua_ls.setup({
                    capabilities = capabilities,
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { "vim" }
                            }
                        }
                    }
                })
            end
		},
	})
end
