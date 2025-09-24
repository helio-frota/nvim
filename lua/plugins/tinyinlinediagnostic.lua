return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "VeryLazy",
  priority = 1000,
  config = function()
    require("tiny-inline-diagnostic").setup {
      hi = {
        error = "DiagnosticError",
        warn = "DiagnosticWarn",
        info = "DiagnosticInfo",
        hint = "DiagnosticHint",
        arrow = "NonText",
        background = "CursorLine",
      },
      transparent_bg = true,
      options = {
        use_icons_from_diagnostic = true,
        throttle = 0,
        enable_on_insert = true,
        show_all_diags_on_cursorline = true,
      },
    }
  end,
}
