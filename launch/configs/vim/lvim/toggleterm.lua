---@diagnostic disable: missing-parameter
local status, toggleterm = pcall(require, "toggleterm")
if not status then
  vim.notify("toggleterm not found")
  return
end

toggleterm.setup({
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.3
    end
  end,
  start_in_insert = true,
})

local Terminal = require("toggleterm.terminal").Terminal

local lazygit = Terminal:new({
  cmd = "lazygit",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "double",
  },
  on_open = function(term)
    vim.cmd("startinsert!")
    -- q / <leader>tg 关闭 terminal
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "<leader>tg", "<cmd>close<CR>", { noremap = true, silent = true })
    -- ESC 键取消，留给lazygit
    if vim.fn.mapcheck("<Esc>", "t") ~= "" then
      vim.api.nvim_del_keymap("t", "<Esc>")
    end
  end,
  on_close = function(_)
    -- 添加回来
    vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", {
      noremap = true,
      silent = true,
    })
  end,
})

local toggleMoveWindow = {
  on_open = function(_)
    vim.cmd("startinsert!")
    if vim.fn.mapcheck("<leader>h", "t") ~= "" then
      vim.api.nvim_del_keymap("t", "<leader>h")
    end
    if vim.fn.mapcheck("<leader>j", "t") ~= "" then
      vim.api.nvim_del_keymap("t", "<leader>j")
    end
    if vim.fn.mapcheck("<leader>k", "t") ~= "" then
      vim.api.nvim_del_keymap("t", "<leader>k")
    end
    if vim.fn.mapcheck("<leader>l", "t") ~= "" then
      vim.api.nvim_del_keymap("t", "<leader>l")
    end
  end,
  on_close = function(_)
    local opt = {
      noremap = true,
      silent = true,
    }
    vim.api.nvim_set_keymap("t", "<leader>h", "<C-w>h", opt)
    vim.api.nvim_set_keymap("t", "<leader>j", "<C-w>j", opt)
    vim.api.nvim_set_keymap("t", "<leader>k", "<C-w>k", opt)
    vim.api.nvim_set_keymap("t", "<leader>l", "<C-w>l", opt)
  end,
}

Mergetb = function(t1, t2)
  for k,v in pairs(t2) do
    if type(v) == "table" then
      if type(t1[k] or false) == "table" then
        Mergetb(t1[k] or {}, t2[k] or {})
      else
        t1[k] = v
      end
    else
      t1[k] = v
    end
  end
  return t1
end

local ta = Terminal:new(
  Mergetb({
    direction = "float",
    close_on_exit = true,
  }, toggleMoveWindow)
)

local tb = Terminal:new(
  {
    direction = "vertical",
    close_on_exit = true,
  }
)

local tc = Terminal:new(
  {
    direction = "horizontal",
    close_on_exit = true,
  }
)

local M = {}

M.toggleA = function()
  if ta:is_open() then
    ta:close()
    return
  end
  tb:close()
  tc:close()
  ta:open()
end

M.toggleB = function()
  if tb:is_open() then
    tb:close()
    return
  end
  ta:close()
  tc:close()
  tb:open()
end

M.toggleC = function()
  if tc:is_open() then
    tc:close()
    return
  end
  ta:close()
  tb:close()
  tc:open()
end

M.toggleG = function()
  lazygit:toggle()
end

local pluginKeys = {}

-- 自定义 toggleterm 3个不同类型的命令行窗口
-- <leader>tt 浮动
-- <leader>ty 右侧
-- <leader>tc 下方
-- 特殊lazygit 窗口，需要安装lazygit
-- <leader>tg lazygit
pluginKeys.mapToggleTerm = function(term)
  vim.keymap.set({ "n", "t" }, "<leader>tt", term.toggleA)
  vim.keymap.set({ "n", "t" }, "<leader>ty", term.toggleB)
  vim.keymap.set({ "n", "t" }, "<leader>tu", term.toggleC)
  vim.keymap.set({ "n", "t" }, "<leader>tg", term.toggleG)
end

pluginKeys.mapToggleTerm(M)

