return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        float_opts = {
          border = "curved",
          width = 120,
          height = 26,
        },
        highlights = {
          FloatBorder = {
            guifg = "#89b4fb",
          },
        },
      })
    end,
  },
  { "voldikss/vim-floaterm" },
}
