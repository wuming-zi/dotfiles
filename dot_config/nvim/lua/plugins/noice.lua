return {
  "folke/noice.nvim",
  opts = {
    presets = {
      lsp_doc_border = false, -- lsp的文档提示增加边框装饰
    },
    routes = {
      {
        filter = {
          event = "msg_show",
          find = "Translate success", -- 过滤翻译成功的通知
        },
        opts = { skip = true },
      },
    },
  },
}
