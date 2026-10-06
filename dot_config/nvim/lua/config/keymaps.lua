-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap

--- ------- 插入模式 ----------
-- 按下jk回到正常模式
keymap.set("i", "jk", "<ESC>")

-- -------- 视觉模式 ----------
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- -------- 正常模式 ----------

vim.keymap.set("i", "<Esc>", function()
  local win = vim.api.nvim_get_current_win()
  local cfg = vim.api.nvim_win_get_config(win)
  if cfg.relative ~= "" then -- 是浮动窗口
    pcall(vim.api.nvim_win_close, win, true)
  else
    vim.cmd("stopinsert") -- 普通窗口：只退出插入模式
  end
end, { desc = "Esc: close floating windows or back to insert mode" })
