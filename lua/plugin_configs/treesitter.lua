local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

configs.setup({
	-- 自动安装所有语言
	auto_install = true,
    
    -- 确保安装基础语言
    ensure_installed = {
		"vim",
		"vimdoc",
		"bash",
		"c",
		"cpp",
		"javascript",
		"json",
		"lua",
		"python",
		"typescript",
		"css",
		"scss",
		"rust",
		"markdown",
		"markdown_inline",
		"html",
	},

	highlight = { enable = true },
	indent = { enable = true },

	-- 强制使用 git 和本地编译器，同时明确指定编译器
	install = {
		prefer_git = true,
	},
})

-- 强制指定编译器，防止它去找 cli
local install_status_ok, ts_install = pcall(require, "nvim-treesitter.install")
if install_status_ok then
	ts_install.compilers = { "gcc", "clang", "cc" }
end
