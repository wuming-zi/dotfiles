return {
  {
    "noir4y/comment-translate.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("comment-translate").setup({
        target_language = "zh_cn",

        hover = {
          enabled = true,
          delay = 500,
          auto = false,
        },
        -- 沉浸式内联翻译
        immersive = {
          enabled = false,
        },
        cache = {
          enabled = true,
          max_entries = 1000,
        },
        max_length = 5000,
        targets = {
          comment = true,
          string = true,
        },

        translate_service = "llm",
        llm = {
          provider = "openai",
          api_key = os.getenv("DEEPSEEK_API_KEY"),
          model = "deepseek-flash",
          endpoint = "https://api.deepseek.com/chat/completions",
          system_prompt = nil,
          timeout = 20,
        },
        -- ===== Google 备用（取消注释切换） =====
        -- translate_service = "google",
        --  llm = {
        --    provider = "openai", -- 兼容 OpenAI API 的都可选 'openai'
        --    api_key = nil, -- 留空则从环境变量读取（见下方说明）
        --    model = "gpt-5.2", -- 会被您的 endpoint 覆盖，但需填一个占位
        --    endpoint = nil, -- 下面会针对不同服务给出具体值
        --    system_prompt = nil, -- 使用插件内置的翻译提示词（效果不错）
        --    timeout = 20,
        --  },

        keymaps = {
          hover = "<leader>th", -- 手动悬停翻译
          hover_manual = "<leader>tc", -- 强制触发悬停（即使 auto=false）
          replace = "<leader>tr", -- 替换选中文本
          toggle = "<leader>tt", -- 切换沉浸模式
        },
      })
    end,
  },
}
