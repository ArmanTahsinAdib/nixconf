return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        float_opts = {
          border = "curved",
          width = 100,
          height = 22,
        },
      })
    end,
  },
  { "voldikss/vim-floaterm" },
}
