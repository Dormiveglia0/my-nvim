require('smear_cursor').setup({
    cursor_color = "#fff3b0",
    
    -- 恢复你原本喜欢的物理参数，保留拖尾的长度和动态感
    stiffness = 0.3,
    trailing_stiffness = 0.1,
    trailing_exponent = 5,
    gamma = 1,

    -- ==========================================
    -- 🌟 核心修复：解决“一个个方块”的断层感
    -- ==========================================
    
    -- 启用真正的“线条”渲染模式，而不是离散的方块
    -- 这样光标移动时会渲染成一条连续的矩阵线
    smear_between_neighbor_lines = true,
    
    -- 降低透明度衰减，让线条更连贯
    min_alpha = 0.05,
    
    -- 开启传统终端兼容模式（如果你的终端不支持高级图形混合，这能极大改善方块感）
    legacy_computing_symbols_support = true,
})
