return {
  "echasnovski/mini.nvim",
  config = function()
    require("mini.align").setup()
    require("mini.basics").setup()
    require("mini.cursorword").setup()
    require("mini.diff").setup()
    require("mini.extra").setup()
    require("mini.files").setup()
    require("mini.git").setup()
    require("mini.indentscope").setup()
    require("mini.move").setup()
    require("mini.pairs").setup()
    require("mini.pick").setup()
    require("mini.tabline").setup()
    require("mini.trailspace").setup()

    local misc = require "mini.misc"
    misc.setup_termbg_sync()
    -- local statusline = require "mini.statusline"
    -- statusline.setup { use_icons = true }
    -- statusline.section_location = function()
    --   return "%2l:%-2v"
    -- end
    local hipatterns = require "mini.hipatterns"
    hipatterns.setup {
      highlighters = {
        fixme = {
          pattern = "%f[%w]()FIXME()%f[%W]",
          group = "MiniHipatternsFixme",
        },
        hack = {
          pattern = "%f[%w]()HACK()%f[%W]",
          group = "MiniHipatternsHack",
        },
        todo = {
          pattern = "%f[%w]()TODO()%f[%W]",
          group = "MiniHipatternsTodo",
        },
        note = {
          pattern = "%f[%w]()NOTE()%f[%W]",
          group = "MiniHipatternsNote",
        },
        hex_color = hipatterns.gen_highlighter.hex_color(),
      },
    }

    local minidiff = require "mini.diff"
    minidiff.setup {
      view = {
        style = "sign",
        signs = { add = "+", change = "~", delete = "-" },
      },
    }

    local miniclue = require "mini.clue"
    miniclue.setup {
      triggers = {
        { mode = "n", keys = "<Leader>" },
      },

      clues = {
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),
      },
      window = {
        config = { width = "auto", anchor = "SE", row = "auto", col = "auto" },
      },
    }
  end,
}
