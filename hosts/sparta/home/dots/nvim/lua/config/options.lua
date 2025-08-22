vim.o.swf = false
vim.o.scs = false
vim.o.culopt = "number"
vim.o.so = 10
vim.o.winborder = "single"
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.env.TERM = "xterm-kitty"



vim.g.lazyvim_python_lsp = "pyright"


-- Define a highlight group called MyHighlight with some style
vim.api.nvim_set_hl(0, "MyHighlight", {
  fg = "#1e222a",    -- background color
  bg = "#89b4fb",    -- foreground color
  bold = true,
  italic = false,
})
