local opt = vim.opt

-- 行号
opt.relativenumber = true
opt.number = true

-- 缩进
opt.tabstop = 2 -- 制表符显示为4个空格宽
opt.shiftwidth = 4 -- 用于自动缩进的宽度
opt.expandtab = false -- 使用制表符进行缩进
opt.autoindent = true

-- 自动换行
opt.wrap = false
-- 光标行
opt.cursorline = true

-- 启用鼠标
opt.mouse:append("a")

-- 系统剪贴板
opt.clipboard:append("unnamedplus")

-- 强制 Neovim 使用 OSC 52 与终端通信来实现剪贴板同步
vim.g.clipboard = {
	name = "OSC 52",
	copy = {
		["+"] = require("vim.ui.clipboard.osc52").copy("+"),
		["*"] = require("vim.ui.clipboard.osc52").copy("*"),
	},
	paste = {
		-- 放弃向终端请求，直接返回 Neovim 内部寄存器 (") 的内容
		["+"] = function()
			return vim.fn.getreg('"', 1, true)
		end,
		["*"] = function()
			return vim.fn.getreg('"', 1, true)
		end,
	},
}
-- 默认新窗口右和下
opt.splitright = true
opt.splitbelow = true

-- 搜索
opt.ignorecase = true
opt.smartcase = true

-- 外观
opt.termguicolors = true
opt.signcolumn = "yes"

-- 分屏分割线
vim.opt.laststatus = 3
vim.opt.fillchars:append({
	horiz = "━", -- 水平分割线字符
	horizup = "┻",
	horizdown = "┳",
	vert = "┃", -- 垂直分割线字符
	vertleft = "┫",
	vertright = "┣",
	verthoriz = "╋",
})
vim.cmd([[
  highlight WinSeparator guifg=#c6a0f6 gui=bold
]])
