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
keymap({ "n", "v" }, "H", "^", opts) -- 行首
keymap({ "n", "v" }, "L", "$", opts) -- 行尾

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
