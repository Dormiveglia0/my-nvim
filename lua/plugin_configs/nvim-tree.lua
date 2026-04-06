-- 默认不开启 netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- 自定义快捷键映射函数
local function my_on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	api.config.mappings.default_on_attach(bufnr)

	local function open_and_step_in()
		local node = api.tree.get_node_under_cursor()

		if node.nodes ~= nil then
			-- 如果是目录
			if not node.open then
				-- 如果目录未展开，先展开它
				api.node.open.edit()
				-- 展开后，光标向下移动一行，正好落在第一个子文件/子目录上
				vim.cmd("normal! j")
			else
				-- 如果目录已经展开了，直接向下移动一行进去
				vim.cmd("normal! j")
			end
		else
			-- 如果是普通文件，直接打开它
			api.node.open.edit()
		end
	end

	-- 绑定增强版的 l 键
	vim.keymap.set("n", "l", open_and_step_in, opts("Open and Step In"))

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
