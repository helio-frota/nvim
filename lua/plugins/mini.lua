return {
  "echasnovski/mini.nvim",
  config = function()
    require("mini.cursorword").setup()
    require("mini.clue").setup()
    require("mini.align").setup()
    require("mini.comment").setup()
    require("mini.pairs").setup()
    require("mini.starter").setup()
    require("mini.tabline").setup()
    require("mini.files").setup()
    local statusline = require "mini.statusline"
    statusline.setup { use_icons = true }
    statusline.section_location = function()
      return "%2l:%-2v"
    end
  end,
}
