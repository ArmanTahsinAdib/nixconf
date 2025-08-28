local key = vim.keymap
local opts = { noremap = true, silent = true }

key.set("n", "<C-a>", "<cmd>normal! ggVG<CR>")
key.set("n", "<C-s>", "<cmd>up<CR>", opts)

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
key.set({ "n", "t" }, "<C-`>", "<cmd>ToggleTerm direction=float<CR>", opts)
key.set({ "n", "t" }, "<M-v>", "<cmd>ToggleTerm direction=vertical size=30<CR>", opts)

-- key.set("n", "<leader>s", "<cmd>split<CR>", opts)
-- key.set("n", "<leader>v", "<cmd>vsplit<CR>", opts)
-- key.set("n", "sx", "<cmd>bd<CR>", opts)
-- key.set("n", "sa", "<cmd>BufferLineCloseOthers<CR>", opts)
--
key.set({ "n", "i" }, "<M-z>", function()
  vim.wo.wrap = not vim.wo.wrap
  print("Wrap: " .. (vim.wo.wrap and "ON" or "OFF"))
end, { desc = "Toggle line wrap" })

vim.api.nvim_create_user_command("Wsudo", function()
  local pass = vim.fn.inputsecret("Password: ")
  vim.cmd("write !echo " .. pass .. "|sudo -S tee % > /dev/null")
  -- vim.cmd("write !sudo  tee % > /dev/null")
  vim.cmd("edit!")
end, {})

key.set("n", "<leader>W!", ":Wsudo<CR>", { noremap = true, silent = true })
key.set("n", "<leader>w!", ":SudaRead<CR>", opts)

key.set("n", "<leader><leader>", function()
  local base_dir = vim.fn.expand("%:p:h")
  Snacks.picker.files({
    cwd = base_dir,
    on_show = function()
      vim.cmd.stopinsert()
    end,
    layout = {
      preset = "vscode",
    },
  })
end, { desc = "Search files in directory of current file" })

key.set({ "n", "v" }, "<C-.>", vim.lsp.buf.code_action)
key.set({ "n", "v", "i" }, "<M-c>", "<cmd>Outline<CR>", opts)
key.set("t", "", "", opts)

key.set("i", "<C-Right>", function()
  if require("copilot.suggestion").is_visible() then
    require("copilot.suggestion").accept_word()
  else
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-Right>", true, false, true), "n", true)
  end
end)

-- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-Right>", true, false, true), "n", true)
