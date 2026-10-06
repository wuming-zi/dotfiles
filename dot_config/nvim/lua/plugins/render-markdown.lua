return {
  "MeanderingProgrammer/render-markdown.nvim",
  lazy = true, -- 延迟加载
  event = "BufReadPre *.md", -- 只在打开 md 文件时加载
  opts = {},
}
