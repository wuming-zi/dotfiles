return {
  "HiPhish/rainbow-delimiters.nvim",
  event = { "BufReadPost", "BufNewFile" }, -- 懒加载：打开文件时
  config = function()
    require("rainbow-delimiters.setup").setup({})
  end,
}
