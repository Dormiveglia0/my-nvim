require('smear_cursor').setup({
    cursor_color = "#fff3b0",
    
    -- 官方文档推荐的 "Faster smear" (更快的拖影) 配置
    -- 这会让拖影变得非常干脆、灵动，完全消除掉帧的粘滞感
    stiffness = 0.8,
    trailing_stiffness = 0.6,
    stiffness_insert_mode = 0.7,
    trailing_stiffness_insert_mode = 0.7,
    damping = 0.95,
    damping_insert_mode = 0.95,
    distance_stop_animating = 0.5,

    -- 降低绘制间隔，提高帧率 (默认 17ms，降低到 7ms 会让动画更丝滑)
    time_interval = 7,

    -- ==========================================
    -- 🌟 解决透明背景下的方块/阴影问题
    -- ==========================================
    -- 官方说明：如果你的终端字体不支持 legacy_computing_symbols，
    -- 在透明背景下会有明显的阴影/方块感。
    -- 我们设置一个接近你主题的深色作为 fallback，能极大减轻方块感。
    transparent_bg_fallback_color = "#303030",
})
