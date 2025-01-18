return {
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
}
