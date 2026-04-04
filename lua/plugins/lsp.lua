local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_nvim_lsp_status_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
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
                package_uninstalled = "✗"
            }
        }
    })
end

local mason_lspconfig_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if mason_lspconfig_status_ok then
    mason_lspconfig.setup({
        ensure_installed = {
            "vtsls", "cssls", "html", "clangd"
        },
        automatic_installation = true,
    })
end

-- =====================================================================
-- 修复 Neovim 0.11 lspconfig 废弃警告
-- 在 Neovim 0.11 中，require('lspconfig').server.setup() 被废弃
-- 推荐使用 vim.lsp.config API，但为了兼容性，我们使用 mason-lspconfig 的 setup_handlers
-- =====================================================================
if mason_lspconfig_status_ok then
    mason_lspconfig.setup_handlers({
        -- 默认处理程序：为所有服务器自动应用 capabilities
        function(server_name)
            -- 使用 pcall 避免崩溃，如果 lspconfig 真的不可用
            local status_ok, lspconfig = pcall(require, "lspconfig")
            if status_ok then
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
end
