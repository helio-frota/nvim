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
        ensure_installed = { "lua_ls", "taplo" },
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
      -- require("lsp_lines").setup {
      --   box_drawing_characters = {
      --     vertical = "|",
      --     vertical_right = "+",
      --     horizontal_up = "+",
      --     cross = "+",
      --     up_right = "+",
      --     horizontal = "-",
      --   },
      -- }

      local signs = { ERROR = "", WARN = "", INFO = "", HINT = "" }
      local diagnostic_signs = {}
      for type, icon in pairs(signs) do
        diagnostic_signs[vim.diagnostic.severity[type]] = icon
      end

      vim.diagnostic.config {
        signs = { text = diagnostic_signs },
        virtual_text = false,
        float = {
          source = "always",
          border = "rounded",
        },
        severity_sort = true,
        virtual_lines = { highlight_whole_line = false },
      }

      -- vim.diagnostic.config {
      --   virtual_lines = true,
      --   virtual_text = {
      --     source = "always",
      --     prefix = "■",
      --   },
      --   -- virtual_text = false,
      --   float = {
      --     source = "always",
      --     border = "rounded",
      --   },
      --   signs = true,
      --   underline = false,
      --   update_in_insert = false,
      --   severity_sort = true,
      -- }

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
