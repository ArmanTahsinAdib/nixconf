return {
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        component_separators = "|",
        section_separators = { left = "", right = "" },
      },
    },
  },
{
    "saghen/blink.cmp",
    opts = {
      completion = {
        menu = {
          winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:MyHighlight,Search:None',
          border = 'rounded',
          scrollbar = false,
        },
        documentation = { window = {border = 'rounded'}},
      },
    },
  }
}
