vim.cmd [[highlight clear]]

vim.cmd [[
  hi DiagnosticUnderlineError guisp=#FF0080 gui=undercurl
  hi DiagnosticUnderlineHint guisp=#F4C82D gui=undercurl
  hi DiagnosticUnderlineWarning guisp=#F4C82D gui=undercurl
]]

-- minimal colorscheme based on Eclipse IDE 3.6 Helios

local attribute = "#646464"
local comment = "#3F7F5F"
local comment_doc = "#3F5FBF"
local string = "#2A00FF"
local variable_member = "#0000C0"
local const = "#0000C0"
local static = "#0000C0"
local character = "#2A00FF"
local number = "#000000"
local boolean = "#7F0055"
local punct_bracket = "#000000"
local unnecessary = "#000000"
local string_escape = "#2A00FF"
local cursor_line = "#E8F2FE"
local keyword = "#7F0055"
local keyword2 = "#000000"
local ffunction = "#000000"
local function_builtin = "#000000"
local function_macro = "#000000"
local line_number = "#787878"
local inc_search = "#F4C82D"
local normal_bg = "#FEFEFE"
local normal_fg = "#000000"
local visual_bg = "#0078D7"
local visual_fg = "#FEFEFE"

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.schedule(function()
      vim.api.nvim_set_hl(0, "Boolean", { fg = boolean, bold = true })
      vim.api.nvim_set_hl(0, "Character", { fg = character })
      vim.api.nvim_set_hl(0, "Comment", { fg = comment })
      vim.api.nvim_set_hl(0, "CommentDoc", { fg = comment_doc })
      vim.api.nvim_set_hl(0, "CursorLine", { bg = cursor_line })
      vim.api.nvim_set_hl(0, "Function", { fg = ffunction })
      vim.api.nvim_set_hl(0, "FunctionBuiltin", { fg = function_builtin })
      vim.api.nvim_set_hl(0, "FunctionMacro", { fg = function_macro })
      vim.api.nvim_set_hl(0, "IncSearch", { bg = inc_search })
      vim.api.nvim_set_hl(0, "Keyword", { fg = keyword, bold = true })
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
      vim.api.nvim_set_hl(0, "@comment.documentation", { link = "CommentDoc" })
      vim.api.nvim_set_hl(0, "@lsp.mod.documentation", { link = "CommentDoc" })
      vim.api.nvim_set_hl(0, "@lsp.type.property", { fg = variable_member })
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
      vim.api.nvim_set_hl(0, "@attribute", { fg = attribute })
      vim.api.nvim_set_hl(0, "@variable.builtin", { link = "Keyword" })
      vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { fg = unnecessary, strikethrough = true, bold = true })
      vim.api.nvim_set_hl(0, "@lsp.type.const.rust", { fg = const })
      vim.api.nvim_set_hl(0, "@lsp.type.static.rust", { fg = static })

      -- mini status line
      vim.api.nvim_set_hl(0, "MiniStatuslineModeNormal", { fg = "#fefefe", bg = "#0000C0" })
      vim.api.nvim_set_hl(0, "MiniStatuslineModeInsert", { fg = "#fefefe", bg = "#22A463" })
      vim.api.nvim_set_hl(0, "MiniStatuslineModeVisual", { fg = "#fefefe", bg = "#0080FF" })
      vim.api.nvim_set_hl(0, "MiniStatuslineModeReplace", { fg = "#fefefe", bg = "#F4C82D" })
      vim.api.nvim_set_hl(0, "MiniStatuslineModeCommand", { fg = "#fefefe", bg = "#2A00FF" })

      vim.api.nvim_set_hl(0, "MiniHipatternsFixme", { fg = "#fefefe", bg = "#FF0080" })
      vim.api.nvim_set_hl(0, "MiniHipatternsHack", { fg = "#fefefe", bg = "#F4C82D" })
      vim.api.nvim_set_hl(0, "MiniHipatternsNote", { fg = "#fefefe", bg = "#22A463" })
      vim.api.nvim_set_hl(0, "MiniHipatternsTodo", { fg = "#fefefe", bg = "#0080FF" })

      vim.api.nvim_set_hl(0, "DiagnosticError", { fg = "#FF0080", bold = true })
      vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = "#F4C82D", bold = true })
      vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = "#F4C82D", bold = true })
      vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = "#F4C82D", bold = true })
    end)
  end,
})
