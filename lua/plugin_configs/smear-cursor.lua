require('smear_cursor').setup({
	-- smear cursor when switching buffers or windows.
	smear_between_buffers = true,

	-- smear cursor when moving within line or to neighbor lines.
	-- use `min_horizontal_distance_smear` and `min_vertical_distance_smear` for finer control
	smear_between_neighbor_lines = true,

	-- draw the smear in buffer space instead of screen space when scrolling
	scroll_buffer_space = true,
	-- 是否在内置终端模式下启用拖影。
	smear_terminal_mode = true,
	-- smears and particles will look a lot less blocky.
	legacy_computing_symbols_support = true,
	-- smear cursor in insert mode.
	stiffness = 0.6,                   -- 0.6      [0, 1]
	trailing_stiffness = 0.2,          -- 0.45     [0, 1]
	stiffness_insert_mode = 0.6,       -- 0.5      [0, 1]
	trailing_stiffness_insert_mode = 0.3, -- 0.5      [0, 1]
	damping = 0.55,                    -- 0.85     [0, 1]
	damping_insert_mode = 0.95,        -- 0.9      [0, 1]
	distance_stop_animating = 0.5,     -- 0.1      > 0
	trailing_exponent = 6,             -- 控制拖影中间部分的形态。<1 时中间点更靠近尾部，>1 时更靠近头部。
	max_length = 100,
	time_interval = 7,                 -- 核心：把渲染间隔从 17ms 降低到 7ms，大幅提高帧率
	-- see also `vertical_bar_cursor_insert_mode` and `distance_stop_animating_vertical_bar`.
})

-- require('smear_cursor').setup({
-- 	cursor_color = "#fff3b0",
-- 	smear_between_neighbor_lines = true,
--
-- 	-- draw the smear in buffer space instead of screen space when scrolling
-- 	scroll_buffer_space = true,
--
-- 	-- 恢复你原本喜欢的物理参数，保留拖尾的长度和动态感
-- 	stiffness = 0.3,
-- 	trailing_stiffness = 0.3,
-- 	damping = 0.65,
-- 	trailing_exponent = 5,
-- 	-- gamma = 1,
--
-- 	-- 降低透明度衰减，让线条更连贯
-- 	-- min_alpha = 0.05,
-- 	-- 核心：把渲染间隔从 17ms 降低到 7ms，大幅提高帧率
-- 	time_interval = 7,
-- 	-- 开启传统终端兼容模式（如果你的终端不支持高级图形混合，这能极大改善方块感）
-- 	legacy_computing_symbols_support = true,
-- })
