return {
  "petertriho/nvim-scrollbar",
  dependencies = {
    "kevinhwang91/nvim-hlslens",
    "lewis6991/gitsigns.nvim",
  },
  opts = {
    handle = {
      -- color = "#0000ff",
      hide_if_all_visible = true,
    },
  },
  config = function(_, opts)
    require("scrollbar").setup(opts)
    require("scrollbar.handlers.search").setup {
      override_lens = function() end,
    }
    require("scrollbar.handlers.gitsigns").setup()
  end,
}
