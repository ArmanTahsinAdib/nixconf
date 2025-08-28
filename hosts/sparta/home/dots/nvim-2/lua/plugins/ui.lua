return {
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        component_separators = "|",
        section_separators = { left = "", right = "" },
        -- section_separators = { left = "", right = "" },
        -- component_separators = { left = "", right = "" },
      },
    },
  },
  {
    "b0o/incline.nvim",
    config = function()
      local helpers = require("incline.helpers")
      local devicons = require("nvim-web-devicons")
      require("incline").setup({
        window = {
          padding = 0,
          margin = { horizontal = 0 },
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if filename == "" then
            filename = "[No Name]"
          end
          local ft_icon, ft_color = devicons.get_icon_color(filename)
          local modified = vim.bo[props.buf].modified

          return {
            ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or "",
            " ",
            { filename, gui = modified and "bold,italic" or "bold" },
            " ",
            guibg = "#44406e",
          }
        end,
      })
    end,
  },

  {

    "folke/noice.nvim",
    opts = {
      presets = {
        lsp_doc_border = true,
      },
      cmdline = {
        format = {
          filter = { icon = "" },
          python = {
            pattern = { "^:%s*py%s+", "^:%s*python%s+", "^:%s*python3%s+" },
            icon = "",
            lang = "python",
          },
          set = {
            pattern = { "^:%s*set%s+", "^:%s*se%s+" },
            icon = " ",
            lang = "set",
          },
        },
      },
    },
  },

  {
    "saghen/blink.cmp",
    build = "cargo build --release",
    opts = {
      completion = {
        menu = {
          winhighlight = "FloatBorder:blinkborder,CursorLine:blinkcursor,Search:None",
          border = "rounded",
          scrollbar = false,
        },
        documentation = {
          window = {
            border = "rounded",
            winhighlight = "FloatBorder:blinkborder,CursorLine:blinkcursor,Search:None",
          },
        },

        list = { selection = { auto_insert = false } },
        ghost_text = {
          enabled = false,
        },
      },
    },
  },
}
