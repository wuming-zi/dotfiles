return {
  "rmagatti/auto-session",
  enabled = false, -- snacks默认提供persistence
  lazy = false,
  opts = {
    auto_restore = true,
    auto_save = true,
    -- 不保存这些文件类型
    filetypes_ignore = {
      "snacks_explorer", -- Snacks 文件树
      "TelescopePrompt",
      "alpha",
      "dashboard",
    },
    -- 恢复后自动打开 Snacks 文件树
    post_restore_cmds = {
      function()
        -- 延迟一点确保 session 完全恢复
        vim.defer_fn(function()
          -- 打开 snacks explorer
          require("snacks").explorer.open()
          -- 再延迟一点切换焦点到主窗口
          vim.defer_fn(function()
            vim.cmd("wincmd l") -- 切换到右侧窗口
          end, 50)
        end, 100)
      end,
    },
  },
}
