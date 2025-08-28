return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        emmet_language_server = {},
        tailwindcss = {},
        -- pyright = {},
        -- pylsp = {
        --   signature = {
        --     formatter = "ruff",
        --   },
        -- },
        html = {},
        cssls = {},
        hyprls = {},
        nixd = {
          cmd = { "nixd", "--semantic-tokens=true" },
          settings = {
            nixd = {
              nixpkgs = {
                expr = "import <nixpkgs> { }",
              },
              diagnostic = {
                suppress = {
                  "sema-extra-with",
                },
              },
              options = {
                -- nixos = {
                --   expr = '(builtins.getFlake "/home/arman-adib/nixconf").nixosConfigurations."sparta".options',
                -- },
                home_manager = {
                  expr = '(builtins.getFlake "/home/arman-adib/.config/home-manager").homeConfigurations."arman-adib".options',
                },
              },
            },
          },
        },
      },
      setup = {
        -- ["ruff"] = function()
        --   LazyVim.lsp.on_attach(function(client, _)
        --     client.server_capabilities.hoverProvider = false
        --     client.server_capabilities.diagnosticProvider = nil
        --   end, "ruff")
        -- end,
        -- ["pyright"] = function()
        --   LazyVim.lsp.on_attach(function(client, _)
        --     -- client.server_capabilities.hoverProvider = false
        --     client.server_capabilities.completionProvider = nil
        --     client.server_capabilities.signatureHelpProvider = nil
        --   end, "pyright")
        -- end,
      },
    },
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy", -- Or `LspAttach`
    priority = 1000,
    config = function()
      require("tiny-inline-diagnostic").setup({
        hi = {
          background = "None",
        },
      })
      vim.diagnostic.config({ virtual_text = false }) -- Only if needed in your configuration, if you already have native LSP diagnostics
    end,
  },
}
