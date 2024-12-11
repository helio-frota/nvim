-- File Explorer / Tree
return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- Fancy icon support
  },
  opts = {
    update_focused_file = {
      enable = true,
    },
    actions = {
      open_file = {
        window_picker = {
          enable = false,
        },
      },
    },
    renderer = {
      icons = {
        webdev_colors = true,
        show = {
          git = true,
          folder_arrow = false,
        },
        glyphs = {
          default = "",
          folder = {
            default = "",
            open = "",
            empty = "",
            empty_open = "",
          },
        },
      },
    },
    diagnostics = {
      enable = true,
      show_on_dirs = false,
      icons = {
        hint = "",
        info = "",
        warning = "",
        error = "",
      },
    },
  },
  config = function(_, opts)
    require("nvim-tree").setup(opts)
  end,
}
