return {
  "echasnovski/mini.nvim",
  config = function()
    require("mini.align").setup()
    require("mini.comment").setup()
    require("mini.cursorword").setup()
    require("mini.files").setup()
    require("mini.icons").setup()
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
        hex_color = hipatterns.gen_highlighter.hex_color(),
      },
    }

    local miniclue = require "mini.clue"
    miniclue.setup {
      triggers = {
        { mode = "n", keys = "<Leader>" },
        { mode = "x", keys = "<Leader>" },
        { mode = "i", keys = "<C-x>" },
        { mode = "n", keys = "g" },
        { mode = "x", keys = "g" },
        { mode = "n", keys = "'" },
        { mode = "n", keys = "`" },
        { mode = "x", keys = "'" },
        { mode = "x", keys = "`" },
        { mode = "n", keys = '"' },
        { mode = "x", keys = '"' },
        { mode = "i", keys = "<C-r>" },
        { mode = "c", keys = "<C-r>" },
        { mode = "n", keys = "<C-w>" },
        { mode = "n", keys = "z" },
        { mode = "x", keys = "z" },
      },

      clues = {
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),
      },
    }
  end,
}
