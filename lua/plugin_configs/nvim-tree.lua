-- 默认不开启 netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- 自定义快捷键映射函数
local function my_on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	-- 1. 载入默认的快捷键 (保留大部分原生功能，如 a 新建, d 删除, r 重命名)
	api.config.mappings.default_on_attach(bufnr)

	-- 2. 覆盖/添加你想要的 yazi 风格快捷键

	-- 'l' 键：如果是目录则打开/展开；如果是文件则打开并在右侧编辑
	vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))

	-- 'h' 键：关闭当前目录，或者返回上一级目录
	vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))

	-- (可选) 'H' 键：跳到最顶层根目录
	vim.keymap.set("n", "H", api.tree.change_root_to_parent, opts("Up"))

	-- (可选) 'L' 键：将当前选中的目录设为根目录 (cd 进去)
	vim.keymap.set("n", "L", api.tree.change_root_to_node, opts("CD"))
end

require("nvim-tree").setup({
	-- 挂载我们自定义的快捷键
	on_attach = my_on_attach,

	-- 其他一些让体验更好的配置 (可选)
	view = {
		width = 30, -- 设置文件树宽度
		side = "left",
	},
	actions = {
		open_file = {
			quit_on_open = false, -- 打开文件后，文件树不自动关闭 (如果你喜欢打开就关，设为 true)
		},
	},
})
-- 默认不开启nvim-tree
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
--
-- require("nvim-tree").setup()
