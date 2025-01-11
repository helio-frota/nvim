-- return {
--   {
--     "williamboman/mason.nvim",
--     config = function()
--       require("mason").setup()
--     end,
--   },
--   {
--     "williamboman/mason-lspconfig.nvim",
--     config = function()
--       require("mason-lspconfig").setup {
--         ensure_installed = { "lua_ls", "taplo" },
--       }
--     end,
--   },
--   {
--     "neovim/nvim-lspconfig",
--     dependencies = {
--       "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
--     },
--     lazy = false,
--     config = function(_, opts)
--       require("lsp_lines").setup()
--       vim.diagnostic.config {
--         virtual_text = false,
--       }
--       vim.diagnostic.config { virtual_lines = { highlight_whole_line = false } }
--       local capabilities = require("cmp_nvim_lsp").default_capabilities()
--       local lspconfig = require "lspconfig"
--       lspconfig.lua_ls.setup {
--         capabilities = capabilities,
--       }
--       opts.diagnostics = {
--         float = {
--           border = "rounded",
--         },
--       }
--     end,
--   },
--   {
--     "mrcjkb/rustaceanvim",
--     lazy = false,
--     ft = { "rust" },
--     config = function(_, opts)
--       vim.g.rustaceanvim = vim.tbl_deep_extend("force", {}, opts or {})
--     end,
--     opts = {
--       server = {
--         settings = {
--           ["rust-analyzer"] = {
--             check = {
--               command = "clippy",
--               extraArgs = {
--                 "--",
--                 "-D",
--                 "warnings",
--                 "-D",
--                 "clippy::unwrap_used",
--                 "-D",
--                 "clippy::expect_used",
--                 "--no-deps",
--               },
--             },
--           },
--         },
--       },
--     },
--   },
-- }

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "williamboman/mason.nvim", opts = {} },
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    { "j-hui/fidget.nvim", opts = {} },
    "hrsh7th/cmp-nvim-lsp",
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  },
  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or "n"
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
        map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
        map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
        map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
        map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
        map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
        map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
        map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
        map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
      end,
    })

    local signs = { ERROR = "", WARN = "", INFO = "", HINT = "" }
    local diagnostic_signs = {}
    for type, icon in pairs(signs) do
      diagnostic_signs[vim.diagnostic.severity[type]] = icon
    end
    require("lsp_lines").setup()
    vim.diagnostic.config {
      signs = { text = diagnostic_signs },
      virtual_text = false,
      vim.diagnostic.config { virtual_lines = { highlight_whole_line = false } },
    }

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

    local servers = {
      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      },
    }

    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      "stylua",
    })
    require("mason-tool-installer").setup { ensure_installed = ensure_installed }

    require("mason-lspconfig").setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
          require("lspconfig")[server_name].setup(server)
        end,
      },
    }
  end,
}
