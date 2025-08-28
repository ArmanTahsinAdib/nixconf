return {
  "SunnyTamang/pendulum.nvim",
  config = function()
    require("pendulum").setup({
      lualine = true,
    })
  end,
}
