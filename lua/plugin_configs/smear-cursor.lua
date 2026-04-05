require('smear_cursor').setup({
    cursor_color = "#fff3b0",
    
    -- 提高刚度 (stiffness)，让光标跟随更紧密，减少"低刷新率"的迟滞感
    -- 默认通常在 0.6 左右，0.3 太低会导致反应慢
    stiffness = 0.8,
    
    -- 提高拖尾刚度，让残影收缩得更快，显得更干脆利落
    trailing_stiffness = 0.5,
    
    -- 降低拖尾指数，让残影的长度变短，显得更轻盈
    trailing_exponent = 2,
    
    -- 距离阈值：只有移动超过一定距离才显示残影，避免微调光标时显得粘滞
    distance_stop_animating = 0.1,
})
