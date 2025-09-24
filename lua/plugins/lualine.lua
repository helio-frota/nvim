return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup {
        options = {
          theme = "onelight",
        },
        sections = {
          lualine_y = {
            {
              "diagnostics",
              sources = { "nvim_workspace_diagnostic" },
            },
          },
        },
      }
    end,
  },
}
