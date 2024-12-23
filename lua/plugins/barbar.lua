return {
  "romgrk/barbar.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  opts = {
    tabpages = true,
    sidebar_filetypes = {
      NvimTree = true,
    },
    icons = {
      separator = { left = "|", right = "|" },
      separator_at_end = false,
    },
  },
}
