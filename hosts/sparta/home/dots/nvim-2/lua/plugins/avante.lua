return {
  "yetone/avante.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",

    {
      -- Make sure to set this up properly if you have lazy=true
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
  build = "make",
  opts = {
    provider = "copilot",
    web_search_engine = {
      provider = "tavily",
      proxy = nil,
    },
    windows = {
      edit = {
        border = "rounded",
        start_insert = true,
      },
    },
  },
}
