vim.g.mapleader = " "

local keymap = vim.keymap

-- ---------- 插入模式 ---------- ---
keymap.set("i", "jk", "<ESC>")

-- ---------- 视觉模式 ---------- ---
-- 单行或多行移动
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- ---------- 正常模式 ---------- ---
-- 窗口
keymap.set("n", "<leader>sv", "<C-w>v") -- 水平新增窗口 
keymap.set("n", "<leader>sh", "<C-w>s") -- 垂直新增窗口

-- 取消高亮
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- H移动行首 
keymap.set({"n", "v"}, "H", "^")
-- L移动行尾
keymap.set({"n", "v"}, "L", "$")

-- 空格 + d (或 D) 进行“不留痕迹的纯删除”
keymap.set({"n", "v"}, "<leader>d", '"_d', opt)
keymap.set({"n", "v"}, "<leader>D", '"_D', opt)
-- 将单字符删除 x 彻底丢进黑洞，禁止它污染剪贴板
keymap.set({"n", "v"}, "x", '"_x', opt)
keymap.set({"n", "v"}, "X", '"_X', opt) 
-- 修改 C 的默认行为，修改文本时不存入剪贴板
keymap.set({"n", "v"}, "c", '"_c', opt)
keymap.set({"n", "v"}, "C", '"_C', opt)
-- 可视模式下按 p 粘贴覆盖时，不让被覆盖的内容进入剪贴板！
keymap.set("v", "p", '"_dP', opt)
