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

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if lspconfig_status_ok then
    -- 安全地遍历并配置 LSP，防止因为某个废弃的 LSP (如 vuels) 导致 __index 崩溃
    local servers = { "vtsls", "cssls", "html", "volar" }
    for _, server in ipairs(servers) do
        -- 使用 pcall 检查 lspconfig 中是否存在该 server
        local has_server, _ = pcall(function() return lspconfig[server] end)
        if has_server and lspconfig[server] then
            lspconfig[server].setup({
                capabilities = capabilities
            })
        end
    end

    -- 针对 clangd 的特殊配置
    local has_clangd, _ = pcall(function() return lspconfig.clangd end)
    if has_clangd and lspconfig.clangd then
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
end
