return {
  "RRethy/vim-illuminate",
  event = "LazyFile", -- 打开文件时加载
  opts = {},
  config = function(_, opts)
    require("illuminate").configure(opts)
    
    -- 给与光标所在相同的字符串打上阴影
    vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = "#3a3a3a" })
    vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = "#3a3a3a" })
    vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = "#3a3a3a" })
  end,
}
