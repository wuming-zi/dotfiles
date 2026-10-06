return {
  "nvim-neo-tree/neo-tree.nvim",
  enabled = true,
  opts = {
    window = {
      width = 40, -- 自定义宽度
    },
    filesystem = {
      filtered_items = {
        visible = true,
        show_hidden = true, -- 默认显示隐藏文件
        hide_gitignored = false, -- 也显示 git 忽略的文件
      },
    },
  },
}
