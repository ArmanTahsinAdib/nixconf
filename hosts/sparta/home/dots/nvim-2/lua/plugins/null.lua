return {
  "nvimtools/none-ls.nvim",
  opts = function(_, opts)
    -- null-ls + ruff formatter (use instead of black)
    local null_ls = require("null-ls")
    local helpers = require("null-ls.helpers")
    local methods = require("null-ls.methods")

    local FORMATTING = methods.internal.FORMATTING

    -- Create a custom builtin that runs `ruff format` and reads/writes via stdin
    local ruff_format = helpers.make_builtin({
      name = "ruff_format",
      meta = {
        url = "https://github.com/astral-sh/ruff",
        description = "Use `ruff format` as a formatter (Black alternative).",
      },
      method = FORMATTING,
      filetypes = { "python" },
      generator_opts = {
        command = "ruff", -- ensure `ruff` is installed & in PATH (mason/pipx/pip)
        args = { "format", "--stdin-filename", "$FILENAME", "-" },
        to_stdin = true,
      },
      factory = helpers.formatter_factory,
    })

    null_ls.setup({
      debug = false,
      sources = {
        -- diagnostics (optional) via null-ls builtin if you like:
        -- null_ls.builtins.diagnostics.ruff,
        -- our custom formatter
        ruff_format,
        -- (optionally) other lightweight sources
      },
    })
  end,
}
