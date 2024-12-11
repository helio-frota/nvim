return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup {
        ensure_installed = { "lua_ls" },
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    },
    lazy = false,
    config = function(_, opts)
      require("lsp_lines").setup()
      vim.diagnostic.config {
        virtual_text = false,
      }
      vim.diagnostic.config { virtual_lines = { highlight_whole_line = false } }
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require "lspconfig"
      lspconfig.lua_ls.setup {
        capabilities = capabilities,
      }
      opts.diagnostics = {
        float = {
          border = "rounded",
        },
      }
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    lazy = false,
    ft = { "rust" },
    config = function(_, opts)
      vim.g.rustaceanvim = vim.tbl_deep_extend("force", {}, opts or {})
    end,
    opts = {
      server = {
        settings = {
          ["rust-analyzer"] = {
            check = {
              command = "clippy",
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
          },
        },
      },
    },
  },
}
