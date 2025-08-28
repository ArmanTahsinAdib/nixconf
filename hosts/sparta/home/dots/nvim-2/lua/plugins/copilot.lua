return {
  {
    "zbirenbaum/copilot.lua",
    opts = {
      suggestion = {
        keymap = {
          dismiss = "<C-Esc>",
        },
      },

      disable_limit_reached_message = true,
    },
  },
  -- {
  --   "nvim-lualine/lualine.nvim",
  --   optional = true,
  --   event = "VeryLazy",
  --   opts = function(_, opts)
  --     table.insert(
  --       opts.sections.lualine_x,
  --       2,
  --       LazyVim.lualine.status(LazyVim.config.icons.kinds.Copilot, function()
  --         local clients = package.loaded["copilot"] and LazyVim.lsp.get_clients({ name = "copilot", bufnr = 0 }) or {}
  --         if #clients > 0 then
  --           local status = require("copilot.api").status.data.status
  --           return (status == "InProgress" and "pending") or (status == "Warning" and "error") or "ok"
  --         end
  --       end)
  --     )
  --   end,
  -- },
}
