return {
  {
    "mason-org/mason.nvim",
    dependencies = {
      "mason-org/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      "artemave/workspace-diagnostics.nvim",
    },
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              version = "LuaJIT",
              diagnostics = {
                globals = {
                  "vim",
                  "require",
                },
              },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
              },
              telemetry = {
                enable = false,
              },
            },
          },
        },
        ts_ls = {
          on_attach = function(client, bufnr)
            require("workspace-diagnostics").populate_workspace_diagnostics(
              client,
              bufnr
            )
          end,
        },
        eslint = {},
        fish_ls = {},
      },
    },
    config = function(_, opts)
      require("mason").setup()

      require("mason-lspconfig").setup {
        ensure_installed = {
          "lua_ls",
          "eslint",
          "ts_ls",
          "prettier",
          "stylua",
          "rust_analyzer",
        },
      }

      vim.lsp.enable(opts.servers.lua_ls)
      vim.lsp.enable(opts.servers.ts_ls)
      vim.lsp.enable(opts.servers.fish_ls)
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      vim.lsp.config("rust_analyzer", {
        settings = {
          ["rust-analyzer"] = {
            cargo = {
              features = "all", -- NOTE: not default
            },
            check = {
              command = "clippy", -- NOTE: the default is "check"
              extraArgs = {
                "--",
                "-D",
                "warnings",
                "-D",
                "clippy::unwrap_used",
                "-D",
                "clippy::expect_used",
                "--no-deps",
              },
            },
            files = {
              exclude = {
                ".git",
                ".github",
                "bin",
                "node_modules",
                "target",
              },
            },
          },
        },
      })
      vim.lsp.enable "rust_analyzer"
    end,
  },
}
