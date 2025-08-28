vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("custom lsp options", { clear = true }),
  callback = function()
    vim.diagnostic.config({
      virtual_text = false,
    })
  end,
})
--
-- local copilot = require("copilot.suggestion")
--
-- local last_state = nil
--
-- -- Function to check Copilot state and fire events
-- local function check_copilot_state()
--   local visible = copilot.is_visible()
--
--   if visible and last_state ~= true then
--     vim.cmd("doautocmd User COPILOTVIS")
--   elseif not visible and last_state ~= false then
--     vim.cmd("doautocmd User COPILOTUNVIS")
--   end
--
--   last_state = visible
-- end
--
-- -- Define the events so other parts of config can listen
-- vim.api.nvim_create_autocmd("User", {
--   pattern = "COPILOTVIS",
--   callback = function()
--     print("Copilot suggestion is visible 🚀")
--   end,
-- })
--
-- vim.api.nvim_create_autocmd("User", {
--   pattern = "COPILOTUNVIS",
--   callback = function()
--     print("Copilot suggestion is hidden ❌")
--   end,
-- })
--
-- -- Run check every 100ms
-- vim.fn.timer_start(100, function()
--   check_copilot_state()
-- end, { ["repeat"] = -1 })
