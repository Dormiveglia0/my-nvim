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

-- ==============================================
-- 自动安装 lazy.nvim 插件管理器
-- ==============================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- ==============================================
-- 启动 lazy.nvim 引擎，自动加载 lua/plugins/ 下的所有文件
-- ==============================================
require("lazy").setup("plugins")
