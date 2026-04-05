local npairs_ok, npairs = pcall(require, "nvim-autopairs")
if not npairs_ok then
  return
end

npairs.setup {
  check_ts = true,
  ts_config = {
    lua = { "string", "source" },
    javascript = { "string", "template_string" },
  },
  fast_wrap = {
    map = '<M-e>',
    chars = { '{', '[', '(', '"', "'" },
    pattern = [=[[%'%"%)%>%]%)%}%,]]=],
    end_key = '$',
    keys = 'qwertyuiopzxcvbnmasdfghjkl',
    check_comma = true,
    highlight = 'Search',
    highlight_grey='Comment'
  },
}

-- =====================================================================
-- 适配 Blink.cmp 的括号自动补全
-- =====================================================================
-- 由于我们已经移除了 nvim-cmp，所以不能再 require "nvim-autopairs.completion.cmp"
-- Blink.cmp 默认已经内置了很好的括号补全支持，或者我们可以通过 blink 的事件系统来处理
-- 目前 nvim-autopairs 在基础输入时已经能很好地工作了
