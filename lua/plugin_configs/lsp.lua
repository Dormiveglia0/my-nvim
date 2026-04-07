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
		ensure_installed = { "vtsls", "vue_ls", "clangd", "cssls", "html" },
		automatic_installation = true,
		handlers = {
			function(server_name)
				if server_name == "vtsls" or server_name == "vue_ls" or server_name == "volar" then return end
				lspconfig[server_name].setup({ capabilities = capabilities })
			end,
			["clangd"] = function()
				lspconfig.clangd.setup({
					capabilities = vim.tbl_deep_extend("force", capabilities, { offsetEncoding = { "utf-8", "utf-16" } }),
					cmd = { "clangd" },
					filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
					root_dir = lspconfig.util.root_pattern("compile_commands.json", ".git"),
					single_file_support = true,
				})
			end,
		},
	})
end

-- =====================================================================
-- 🌟 Vue + TS 终极稳定版配置 (放弃 Hybrid Mode，让 Volar 全权接管)
-- =====================================================================

-- 1. 配置 vtsls，但让它【忽略】 .vue 文件
lspconfig.vtsls.setup({
	capabilities = capabilities,
	-- 注意这里：去掉了 "vue"，只让它管 js 和 ts
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	settings = {
		typescript = { preferences = { includePackageJsonAutoImports = "off" } },
		javascript = { preferences = { includePackageJsonAutoImports = "off" } },
	},
})

-- 2. 配置 vue_ls，让它独立接管 .vue 文件
local mason_registry_status_ok, mason_registry = pcall(require, "mason-registry")
local vue_language_server_path = ""
if mason_registry_status_ok then
	pcall(function()
		local vue_pkg = mason_registry.get_package("vue-language-server")
		vue_language_server_path = vue_pkg:get_install_path() .. "/node_modules/@vue/language-server"
	end)
end

-- 获取全局 typescript 的路径 (Volar 需要用到)
local typescript_path = ""
pcall(function()
	local ts_pkg = mason_registry.get_package("typescript")
	typescript_path = ts_pkg:get_install_path() .. "/node_modules/typescript/lib"
end)

lspconfig.vue_ls.setup({
  capabilities = capabilities,
  init_options = {
    vue = {
      hybridMode = false,
    },
    typescript = {
      tsdk = typescript_path,
    },
  },
})
