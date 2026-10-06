return {
  "zyf722/television.nvim",
  enabled = false, -- ⚠️ 先禁用，调试时改成 true
  build = "cargo build --release", -- 需要 Rust 编译
  cmd = { "Tv", "Tv!" }, -- 懒加载：用到才加载

  keys = {
    -- 主键 + ss：智能文件搜索（有 .git 用 git-files，否则 files）
    {
      "<leader>ss",
      function()
        if vim.fs.root(0, ".git") then
          vim.cmd("Tv git-files")
        else
          vim.cmd("Tv files")
        end
      end,
      desc = "Search Files (Smart)",
    },
    -- 主键 + sg：全文内容搜索
    {
      "<leader>sg",
      function()
        vim.cmd("Tv text")
      end,
      desc = "Search Text",
    },
  },

  config = function()
    local h = require("tv").handlers
    require("tv").setup({
      channels = {
        ["git-files"] = {
          handlers = {
            ["<CR>"] = h.open_as_files, -- 打开选中的文件
          },
        },
        files = {
          handlers = {
            ["<CR>"] = h.open_as_files,
          },
        },
        text = {
          handlers = {
            ["<CR>"] = h.open_at_line, -- 跳到 行:列
          },
        },
      },
    })

    -- 保留网友的优秀设计：LSP 预热
    vim.schedule(function()
      vim.api.nvim_exec_autocmds("BufReadPost", { modeline = false })
    end)
  end,
}
