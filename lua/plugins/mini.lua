return {
  "echasnovski/mini.nvim",
  config = function()
    require("mini.align").setup()
    local statusline = require "mini.statusline"
    statusline.setup { use_icons = true }
    statusline.section_location = function()
      return "%2l:%-2v"
    end
  end,
}
