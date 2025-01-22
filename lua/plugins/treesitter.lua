return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  build = ":TSUpdate",
  config = function()
    local configs = require "nvim-treesitter.configs"
    configs.setup {
      ensure_installed = { "lua", "rust" },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
      auto_install = true,
    }
    require("vim.treesitter.query").set("markdown", "highlights", "(fenced_code_block_delimiter) @punctuation.bracket")
  end,
}
