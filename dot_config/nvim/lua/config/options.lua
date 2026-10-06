-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.tabstop = 4 -- Tab 显示的宽度：4 个空格
vim.opt.softtabstop = 4 -- 编辑时按 Tab/Backspace 的步进：4
vim.opt.shiftwidth = 4 -- 自动缩进（>>、=）的宽度：4
vim.opt.expandtab = true -- 按 Tab 插入空格而不是 Tab 字符
vim.opt.smartindent = true -- 智能缩进（按语言自动缩进）

vim.opt.wrap = false -- 不自动换行（长行横向滚动）
vim.opt.swapfile = false -- 不创建 .swp 交换文件
vim.opt.backup = false -- 不创建备份文件

vim.opt.hlsearch = true -- 搜索时高亮所有匹配
vim.opt.incsearch = true -- 输入搜索词时实时高亮

vim.opt.termguicolors = true -- 启用 24 位真彩色
vim.opt.scrolloff = 8 -- 光标离屏幕上下边缘 8 行时开始滚动
vim.opt.signcolumn = "yes" -- 始终显示符号列（LSP 诊断、git 标记）
vim.opt.isfname:append("@-@") -- 把 @ 视为文件名的一部分（利于光标跳转）
vim.opt.wrap = false

vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo" -- undotree持久化位置：~/.local/state/nvim/undo/
