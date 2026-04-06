require('lualine').setup({
	options = {
		-- 使用 auto 会自动跟随当前的 colorscheme (即 catppuccin)
		-- 这样可以完美避开 lualine 和主题插件加载顺序导致的 "Theme not found" 报错
		theme = "auto"
	}
})
