return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  build = ":TSUpdate",
  opts = {
    highlight = {
      enable = true,
    },
    indent = { enable = true },
    auto_install = true,
    ensure_installed = {
      "lua",
    },
  },
  config = function(_, opts)
    local configs = require "nvim-treesitter.configs"
    configs.setup(opts)
  end,
}
