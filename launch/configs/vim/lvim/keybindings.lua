local pluginKeys  = {}

-- 自定义 toggleterm 3个不同类型的命令行窗口
-- <leader>tt 浮动
-- <leader>ty 右侧
-- <leader>tc 下方
-- 特殊lazygit 窗口，需要安装lazygit
-- <leader>tg lazygit
pluginKeys.mapToggleTerm = function(toggleterm)
  vim.keymap.set({ "n", "t" }, "<leader>tt", toggleterm.toggleA)
  vim.keymap.set({ "n", "t" }, "<leader>ty", toggleterm.toggleB)
  vim.keymap.set({ "n", "t" }, "<leader>tu", toggleterm.toggleC)
  vim.keymap.set({ "n", "t" }, "<leader>tg", toggleterm.toggleG)
end

return pluginKeys
