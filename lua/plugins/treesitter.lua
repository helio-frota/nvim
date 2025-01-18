return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  build = ":TSUpdate",
  config = function()
    local configs = require "nvim-treesitter.configs"
    configs.setup {
      ensure_installed = { "lua", "vim", "vimdoc", "rust" },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
      auto_install = true,
    }
  end,
}
