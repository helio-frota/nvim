return {
  "echasnovski/mini.nvim",
  config = function()
    require("mini.align").setup()
    require("mini.clue").setup()
    require("mini.comment").setup()
    require("mini.cursorword").setup()
    require("mini.files").setup()
    require("mini.hipatterns").setup()
    require("mini.notify").setup()
    require("mini.pairs").setup()
    require("mini.starter").setup()
    require("mini.tabline").setup()
    require("mini.trailspace").setup()
    local statusline = require "mini.statusline"
    statusline.setup { use_icons = true }
    statusline.section_location = function()
      return "%2l:%-2v"
    end
    local hipatterns = require "mini.hipatterns"
    hipatterns.setup {
      highlighters = {
        fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
        hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
        todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
        note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
      },
    }
  end,
}
