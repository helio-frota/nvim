return {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup {
        formatters_by_ft = {
          javascript = { "prettier" },
          json = { "prettier" },
          lua = { "stylua" },
          rust = { "rustfmt", lsp_format = "fallback" },
          typescript = { "prettier" },
        },
        format_on_save = {
          timeout_ms = 500,
        },
      }
    end,
}
