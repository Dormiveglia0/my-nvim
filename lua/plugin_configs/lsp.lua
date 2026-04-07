local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_nvim_lsp_status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_nvim_lsp_status_ok then
	capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

local mason_status_ok, mason = pcall(require, "mason")
if mason_status_ok then
	mason.setup({
		ui = {
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
		},
	})
end

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local mason_lspconfig_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if mason_lspconfig_status_ok then
	-- =====================================================================
	-- 在 setup 内部使用 handlers
	-- =====================================================================
	mason_lspconfig.setup({
		ensure_installed = {
			"vtsls",
			"clangd",
			"cssls",
			"html",
		},
		automatic_installation = true,

		-- 核心魔法：这就是替代 setup_handlers 的最新写法！
		handlers = {
			-- 1. 默认处理函数：自动接管所有未特殊指定的 LSP
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
				})
			end,

			-- 2. 特殊处理区

			["vtsls"] = function()
				local mason_registry = require("mason-registry")
				local vue_language_server_path = ""
				pcall(function()
					local vue_pkg = mason_registry.get_package("vue-language-server")
					vue_language_server_path = vue_pkg:get_install_path() .. "/node_modules/@vue/language-server"
				end)

				lspconfig.vtsls.setup({
					capabilities = capabilities,
					filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
					settings = {
						vtsls = {
							tsserver = {
								globalPlugins = {
									{
										name = "@vue/typescript-plugin",
										location = vue_language_server_path,
										languages = { "vue" },
									},
								},
							},
						},
					},
				})
			end,

			["volar"] = function()
				lspconfig.volar.setup({
					capabilities = capabilities,
					init_options = { vue = { hybridMode = true } },
				})
			end,

			["clangd"] = function()
				lspconfig.clangd.setup({
					capabilities = vim.tbl_deep_extend("force", capabilities, {
						offsetEncoding = { "utf-8", "utf-16" },
						textDocument = { completion = { editsNearCursor = true } },
					}),
					cmd = { "clangd" },
					filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
					root_dir = lspconfig.util.root_pattern("compile_commands.json", ".git"),
					single_file_support = true,
				})
			end,
		},
	})
end
