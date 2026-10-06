return {
  "iamcco/markdown-preview.nvim",
  lazy = true,
  event = "BufReadPre *.md",
  build = "cd app && npm install",
  opts = {},
}
