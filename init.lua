-- =====================================================================
-- 全局拦截 Neovim 0.11 的烦人废弃警告 (lspconfig 和 vim.tbl_flatten)
-- 这样可以彻底消除启动时的红字和 lualine 的 notice
-- =====================================================================
local orig_deprecate = vim.deprecate
if orig_deprecate then
    vim.deprecate = function(name, alternative, version, plugin, backtrace)
        if name and type(name) == "string" then
            if name:match("lspconfig") or name:match("vim%.tbl_flatten") then
                return
            end
        end
        orig_deprecate(name, alternative, version, plugin, backtrace)
    end
end

require("core.options")
require("core.keymaps")
require("plugins.plugins-setup")
