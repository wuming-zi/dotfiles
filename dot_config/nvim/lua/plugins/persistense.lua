return {
  "folke/persistence.nvim",
  enabled = true,
  event = "BufReadPre",
  opts = {},
  config = function(_, opts)
    require("persistence").setup(opts)

    -- 自动加载当前目录的会话
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        -- 仅当启动时没有指定文件参数时，才自动恢复
        if vim.fn.argc() == 0 then
          require("persistence").load()
        end
      end,
    })
  end,
}
