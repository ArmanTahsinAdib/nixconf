local key = vim.keymap
local opts = { noremap = true, silent = true }

key.set("n", "<C-a>", "<cmd>normal! ggVG<CR>")

key.set({ "n", "v" }, "+", "<C-a>")
key.set({ "n", "v" }, "g+", "g<C-a>")

key.set({ "n", "v" }, "g-", "g<C-x>")
key.set({ "n", "v" }, "-", "<C-x>")

key.set("n", "L", function()
  local pos = vim.fn.getpos(".") -- Get current cursor position
  vim.cmd("normal! gg=G") -- Indent the whole file
  vim.fn.setpos(".", pos) -- Restore cursor position
end, { silent = true })

key.set("i", "<C-Bs>", "<C-w>")

key.set("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>")
key.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>")

key.set("n", "<M-1>", "<cmd>BufferLineGoToBuffer 1<CR>", opts)
key.set("n", "<M-2>", "<cmd>BufferLineGoToBuffer 2<CR>", opts)
key.set("n", "<M-3>", "<cmd>BufferLineGoToBuffer 3<CR>", opts)
key.set("n", "<M-4>", "<cmd>BufferLineGoToBuffer 4<CR>", opts)
key.set("n", "<M-5>", "<cmd>BufferLineGoToBuffer 5<CR>", opts)
key.set("n", "<M-6>", "<cmd>BufferLineGoToBuffer 6<CR>", opts)
key.set("n", "<M-7>", "<cmd>BufferLineGoToBuffer 7<CR>", opts)
key.set("n", "<M-8>", "<cmd>BufferLineGoToBuffer 8<CR>", opts)
key.set("n", "<M-9>", "<cmd>BufferLineGoToBuffer 0<CR>", opts)

vim.keymap.set("c", "<cr>", function()
  if vim.fn.pumvisible() == 1 then
    return "<c-y>"
  end
  return "<cr>"
end, { expr = true })

key.set("n", "\\", "<leader>fe", { desc = "Explorer NeoTree (cwd)", remap = true })

key.set("n", "<M-q>", function()
  vim.diagnostic.goto_next()
end, opts)

key.set("n", "<leader>r", "<cmd>RunCode<CR>", opts)

key.set({ "n", "t" }, "<M-i>", "<cmd>ToggleTerm direction=float<CR>", opts)

key.set("n", "ss", "<cmd>split<CR>", opts)
key.set("n", "sv", "<cmd>vsplit<CR>", opts)
key.set("n", "sx", "<cmd>bd<CR>", opts)
key.set("n", "sa", "<cmd>BufferLineCloseOthers<CR>", opts)

key.set({ "n", "i" }, "<M-z>", function()
  vim.wo.wrap = not vim.wo.wrap
  print("Wrap: " .. (vim.wo.wrap and "ON" or "OFF"))
end, { desc = "Toggle line wrap" })
