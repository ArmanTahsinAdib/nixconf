return {
  "eandrju/cellular-automaton.nvim",
  { "nvzone/showkeys", cmd = "ShowkeysToggle" },
  {
    "michaelrommel/nvim-silicon",
    lazy = true,
    cmd = "Silicon",
    opts = {
      disable_defaults = false,
      theme = "Dracula",
      font = "JetBrainsMono Nerd Font=34;Noto Emoji",
    },
  },
  {
    "vuciv/golf",
  },
  {
    "lambdalisue/vim-suda",
  },

  -- Example config for lazy.nvim
  {
    "uga-rosa/ccc.nvim",
    config = function()
      require("ccc").setup()
      vim.keymap.set("n", "<leader>cc", "<cmd>CccPick<cr>", { desc = "Pick color" })
    end,
  },
  {
    "vimwiki/vimwiki",
    init = function()
      vim.g.vimwiki_list = {
        {
          path = "~/Documents/vimwiki/",
          -- listsyms = "✗○◐●✓",
        },
      }
      vim.o.compatible = false
      vim.cmd("filetype plugin on")
      vim.cmd("syntax on")
    end,
  },
  { "mattn/calendar-vim" },
}
