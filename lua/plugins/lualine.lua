return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local empty = require("lualine.component"):extend()
    function empty:draw(default_highlight)
      self.status = ""
      self.applied_separator = ""
      self:apply_highlights(default_highlight)
      self:apply_section_separators()
      return self.status
    end

    local function process_sections(sections)
      for name, section in pairs(sections) do
        local left = name:sub(9, 10) < "x"
        for id, comp in ipairs(section) do
          if type(comp) ~= "table" then
            comp = { comp }
            section[id] = comp
          end
          comp.separator = left and { right = "" } or { left = "" }
        end
      end
      return sections
    end

    local function search_result()
      if vim.v.hlsearch == 0 then
        return ""
      end
      local last_search = vim.fn.getreg "/"
      if not last_search or last_search == "" then
        return ""
      end
      local searchcount = vim.fn.searchcount { maxcount = 9999 }
      return last_search .. "(" .. searchcount.current .. "/" .. searchcount.total .. ")"
    end

    local function modified()
      if vim.bo.modified then
        return "+"
      elseif vim.bo.modifiable == false or vim.bo.readonly == true then
        return "-"
      end
      return ""
    end

    require("lualine").setup {
      options = {
        theme = "16color",
        component_separators = "",
        section_separators = { left = "", right = "" },
      },
      sections = process_sections {
        lualine_a = { "mode" },
        lualine_b = {
          "branch",
          "diff",
          {
            "diagnostics",
            source = { "nvim" },
            sections = { "error" },
          },
          {
            "diagnostics",
            source = { "nvim" },
            sections = { "warn" },
          },
          { "filename", file_status = false, path = 1 },
          { modified },
          {
            "%w",
            cond = function()
              return vim.wo.previewwindow
            end,
          },
          {
            "%r",
            cond = function()
              return vim.bo.readonly
            end,
          },
          {
            "%q",
            cond = function()
              return vim.bo.buftype == "quickfix"
            end,
          },
        },
        lualine_c = {},
        lualine_x = {},
        lualine_y = { search_result, "filetype" },
        -- lualine_z = { "%l:%c", "%p%%/%L" },
        lualine_z = {},
      },
      inactive_sections = {
        lualine_c = { "%f %y %m" },
        lualine_x = {},
      },
    }
  end,
}
