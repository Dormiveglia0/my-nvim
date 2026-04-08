vim.g.mapleader = " "

local keymap = vim.keymap.set

-- 默认选项
local opts = { noremap = true, silent = true }

-- =========================================================
-- 插入模式
-- =========================================================

-- jk 快速退出插入模式
keymap("i", "jk", "<ESC>", opts)

-- =========================================================
-- 视觉模式
-- =========================================================

-- 选中文本向下移动
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)

-- 选中文本向上移动
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

-- =========================================================
-- 正常模式
-- =========================================================

-- ---------------------------
-- 取消搜索高亮
-- ---------------------------
keymap("n", "<leader>nh", ":nohl<CR>", opts)

-- ---------------------------
-- 行首行尾
-- ---------------------------
-- 智能行首：第一次按 H 跳到代码开头(^)，再按一次跳到绝对行首(0)
keymap({ "n", "v" }, "H", function()
	local current_col = vim.fn.col(".")
	local first_non_blank = vim.fn.match(vim.fn.getline("."), "\\S") + 1
	if current_col == first_non_blank then
		vim.cmd("normal! 0") -- 如果已经在代码开头，跳到绝对行首
	else
		vim.cmd("normal! ^") -- 否则跳到代码开头
	end
end, { noremap = true, silent = true, desc = "Smart line start" })

-- 行尾保持不变
keymap({ "n", "v" }, "L", "$", opts)

-- =========================================================
-- 黑洞删除（不污染剪贴板）
-- =========================================================

-- leader d 删除但不进入剪贴板
keymap({ "n", "v" }, "<leader>d", '"_d', opts)

-- leader D 删除到行尾
keymap({ "n", "v" }, "<leader>D", '"_D', opts)

-- 单字符删除
keymap({ "n", "v" }, "x", '"_x', opts)
keymap({ "n", "v" }, "X", '"_X', opts)

-- 修改行为
keymap({ "n", "v" }, "c", '"_c', opts)
keymap({ "n", "v" }, "C", '"_C', opts)

-- 可视模式粘贴不污染剪贴板
keymap("v", "p", '"_dP', opts)

-- =========================================================
-- Window Keymaps (leader + w)
-- =========================================================

-- ---------------------------
-- 窗口移动
-- ---------------------------
keymap("n", "<leader>wh", "<C-w>h", { desc = "Move to left window" })
keymap("n", "<leader>wj", "<C-w>j", { desc = "Move to lower window" })
keymap("n", "<leader>wk", "<C-w>k", { desc = "Move to upper window" })
keymap("n", "<leader>wl", "<C-w>l", { desc = "Move to right window" })

-- ---------------------------
-- 窗口切换
-- ---------------------------
keymap("n", "<leader>ww", "<C-w>w", { desc = "Switch window" })
keymap("n", "<leader>wp", "<C-w>p", { desc = "Previous window" })

-- ---------------------------
-- 窗口分割
-- ---------------------------
keymap("n", "<leader>wv", "<C-w>v", { desc = "Vertical split" })
keymap("n", "<leader>ws", "<C-w>s", { desc = "Horizontal split" })

-- ---------------------------
-- 窗口关闭
-- ---------------------------
keymap("n", "<leader>wc", "<C-w>c", { desc = "Close window" })
keymap("n", "<leader>wo", "<C-w>o", { desc = "Only window" })

-- ---------------------------
-- 窗口大小
-- ---------------------------
keymap("n", "<leader>wH", "<C-w>5>", { desc = "Increase width" })
keymap("n", "<leader>wL", "<C-w>5<", { desc = "Decrease width" })
keymap("n", "<leader>wJ", "<C-w>3+", { desc = "Increase height" })
keymap("n", "<leader>wK", "<C-w>3-", { desc = "Decrease height" })

-- 平均窗口
keymap("n", "<leader>w=", "<C-w>=", { desc = "Equal window size" })

-- =========================================================
-- Buffer Keymaps (标签页切换)
-- =========================================================
-- 使用 Tab 和 Shift+Tab 左右切换 Buffer
keymap("n", "<Tab>", ":bnext<CR>", opts)
keymap("n", "<S-Tab>", ":bprevious<CR>", opts)
-- leader + e 呼出/隐藏文件树 (e 代表 explorer)
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
keymap("t", "<leader>\\\\", "<C-\\><C-n>", opts) -- 在终端里按 jk 回到普通模式
-- LSP 快捷键 (LSP Keymaps)
-- 使用 LspAttach 确保只有在 LSP 启动的文件中，这些快捷键才生效
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- 注意：这里必须用 buffer = ev.buf，表示这些快捷键只在当前启用了 LSP 的 buffer 生效
		local lsp_opts = { buffer = ev.buf, silent = true }

		-- 批量重命名变量 (Rename)
		keymap("n", "<leader>rn", vim.lsp.buf.rename, lsp_opts)

		-- 跳转到定义 (Go to Definition)
		keymap("n", "gd", vim.lsp.buf.definition, lsp_opts)

		-- 查看悬浮文档 (Hover)
		keymap("n", "K", vim.lsp.buf.hover, lsp_opts)

		-- 代码动作 (Code Action，比如自动修复报错、自动导入包)
		keymap("n", "<leader>ca", vim.lsp.buf.code_action, lsp_opts)

		-- 查看所有引用 (Go to References)
		keymap("n", "gr", vim.lsp.buf.references, lsp_opts)
	end,
})

-- 诊断信息 (Diagnostics) 快捷键
-- 1. 查看当前行的错误/警告详情（弹出悬浮窗，最常用！）
keymap("n", "gl", vim.diagnostic.open_float, { desc = "Show diagnostic details" })

-- 2. 跳转到上一个/下一个错误或警告（并在跳转后自动显示详情）
keymap("n", "[d", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Previous diagnostic" })
keymap("n", "]d", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next diagnostic" })
-- 3. 在底部打开一个列表，显示当前文件的所有错误和警告
keymap("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Show diagnostics list" })
keymap("n", "<leader>fd", "<cmd>Telescope diagnostics<CR>", { desc = "Find Diagnostics" })
