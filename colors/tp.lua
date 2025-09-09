vim.cmd [[highlight clear]]

-- minimal colorscheme based on old textpad inspired by
-- this work: https://github.com/damc-code/vscode-theme-geal

local comment = "#008000"
local string = "#008080"
local character = "#007676"
local number = "#ad4011"
local boolean = "#ad4011"
local punct_bracket = "#FF0000"
local string_escape = "#FF0000"
local cursor_line = "#fffbf0"
local keyword = "#0000ff"
local keyword2 = "#000080"
local ffunction = "#0000ff"
local function_builtin = "#000080"
local function_macro = "#000080"
local line_number = "#d0d0d0"
local inc_search = "#E6AC00"
local normal_bg = "#fefefe"
local normal_fg = "#000000"
local visual_bg = "#0078D7"
local visual_fg = "#FEFEFE"

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.schedule(function()
      vim.api.nvim_set_hl(0, "Boolean", { fg = boolean })
      vim.api.nvim_set_hl(0, "Character", { fg = character })
      vim.api.nvim_set_hl(0, "Comment", { fg = comment })
      vim.api.nvim_set_hl(0, "CursorLine", { bg = cursor_line })
      vim.api.nvim_set_hl(0, "ColorColumn", { link = "CursorLine" })
      vim.api.nvim_set_hl(0, "Function", { fg = ffunction })
      vim.api.nvim_set_hl(0, "FunctionBuiltin", { fg = function_builtin })
      vim.api.nvim_set_hl(0, "FunctionMacro", { fg = function_macro })
      vim.api.nvim_set_hl(0, "IncSearch", { bg = inc_search })
      vim.api.nvim_set_hl(0, "Keyword", { fg = keyword })
      vim.api.nvim_set_hl(0, "Keyword2", { fg = keyword2 })
      vim.api.nvim_set_hl(0, "LineNr", { fg = line_number })
      vim.api.nvim_set_hl(0, "Normal", { fg = normal_fg, bg = normal_bg })
      vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
      vim.api.nvim_set_hl(0, "Number", { fg = number })
      vim.api.nvim_set_hl(0, "PunctBracket", { fg = punct_bracket })
      vim.api.nvim_set_hl(0, "String", { fg = string })
      vim.api.nvim_set_hl(0, "StringEscape", { fg = string_escape })
      vim.api.nvim_set_hl(0, "Visual", { fg = visual_fg, bg = visual_bg })

      vim.api.nvim_set_hl(0, "@character", { link = "Character" })
      vim.api.nvim_set_hl(0, "@number", { link = "Number" })
      vim.api.nvim_set_hl(0, "@comment", { link = "Comment" })
      vim.api.nvim_set_hl(0, "@lsp.type.property", { link = "Normal" })
      vim.api.nvim_set_hl(0, "@function", { link = "Function" })
      vim.api.nvim_set_hl(0, "@function.builtin", { link = "FunctionBuiltin" })
      vim.api.nvim_set_hl(0, "@function.macro", { link = "FunctionMacro" })
      vim.api.nvim_set_hl(0, "@constant.macro", { link = "FunctionMacro" })
      vim.api.nvim_set_hl(0, "@punctuation.bracket", { link = "PunctBracket" })
      vim.api.nvim_set_hl(0, "@string", { link = "String" })
      vim.api.nvim_set_hl(0, "@string.escape", { link = "StringEscape" })
      vim.api.nvim_set_hl(0, "@keyword", { link = "Keyword" })
      vim.api.nvim_set_hl(0, "@type", { link = "Keyword2" })
      vim.api.nvim_set_hl(0, "@type.builtin", { link = "Keyword2" })
      vim.api.nvim_set_hl(0, "@attribute", { link = "Keyword" })
      vim.api.nvim_set_hl(0, "@variable.builtin", { link = "Keyword" })

      -- mini status line
      vim.api.nvim_set_hl(
        0,
        "MiniStatuslineModeNormal",
        { fg = "#fefefe", bg = "#465A7D" }
      )
      vim.api.nvim_set_hl(
        0,
        "MiniStatuslineModeInsert",
        { fg = "#fefefe", bg = "#008000" }
      )
      vim.api.nvim_set_hl(
        0,
        "MiniStatuslineModeVisual",
        { fg = "#fefefe", bg = "#0078D7" }
      )
      vim.api.nvim_set_hl(
        0,
        "MiniStatuslineModeReplace",
        { fg = "#fefefe", bg = "#E6AC00" }
      )
      vim.api.nvim_set_hl(
        0,
        "MiniStatuslineModeCommand",
        { fg = "#fefefe", bg = "#0000FF" }
      )

      vim.api.nvim_set_hl(
        0,
        "MiniHipatternsFixme",
        { fg = "#fefefe", bg = "#FF0000" }
      )
      vim.api.nvim_set_hl(
        0,
        "MiniHipatternsHack",
        { fg = "#fefefe", bg = "#E6AC00" }
      )
      vim.api.nvim_set_hl(
        0,
        "MiniHipatternsNote",
        { fg = "#fefefe", bg = "#008000" }
      )
      vim.api.nvim_set_hl(
        0,
        "MiniHipatternsTodo",
        { fg = "#fefefe", bg = "#0000FF" }
      )

      vim.api.nvim_set_hl(0, "DiagnosticError", { fg = "#FF0000", bold = true })
      vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = "#E6AC00", bold = true })
      vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = "#0000FF" })
      vim.api.nvim_set_hl(
        0,
        "DiagnosticHint",
        { fg = "#008000", italic = true }
      )
    end)
  end,
})
