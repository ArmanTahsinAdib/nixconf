return {
  {
    "catppuccin/nvim",
    lazy = true,
    priority = 1000,
    name = "catppuccin",
    opts = {
      transparent_background = true,

      auto_integrations = true,

      term_colors = false,
      float = {
        transparent = true,
        solid = false,
      },
    },
  },
  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    config = function()
      require("github-theme").setup({
        options = {

          transparent = true,
        },
      })
    end,
  },

  {
    "olimorris/onedarkpro.nvim",
    priority = 1000, -- Ensure it loads first
    opts = {

      options = {
        cursorline = false, -- Use cursorline highlighting?
        transparency = true,
        terminal_colors = true, -- Use the theme's colors for Neovim's :terminal?
        lualine_transparency = false, -- Center bar transparency?
        highlight_inactive_windows = false, -- When the window is out of focus, change the normal background?
      },
    },
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        styles = {
          transparency = true,
        },
      })
    end,
  },
  {
    "Mofiqul/dracula.nvim",
    config = function()
      require("dracula").setup({
        transparent_bg = true,
      })
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      transparent = true,
    },
  },
  {
    "leobeosab/tearout.nvim",
    lazy = false,
  },

  {
    "LazyVim/LazyVim",

    opts = {
      colorscheme = "rose-pine",
    },
  },
}
