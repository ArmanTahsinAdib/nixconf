vim.o.swf = false
vim.o.scs = false
vim.o.culopt = "number"
vim.o.so = 10
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
-- vim.env.TERM = "xterm-kitty"

vim.g.lazyvim_python_lsp = "pyright"

-- Define a highlight group called MyHighlight with some style
vim.api.nvim_set_hl(0, "blinkcursor", {
  fg = "#1e222a", -- background color
  bg = "#89b4fb", -- foreground color
  bold = true,
  italic = false,
})

vim.api.nvim_set_hl(0, "blinkborder", {
  fg = "#474656", -- background color
  bg = "none", -- foreground color
  bold = true,
  italic = false,
})

vim.diagnostic.config({ virtual_text = false })
vim.g.ai_cmp = false

vim.api.nvim_set_hl(0, "SnacksDashboardNormal", {
  fg = "none",
  bg = "none",
})
--
-- vim.g.vimwiki_list = {
--   {
--     path = "~/Documents/vimwiki/",
--     syntax = "markdown",
--     ext = "md",
--   },
-- }
