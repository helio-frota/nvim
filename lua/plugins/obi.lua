return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  event = {
    "BufReadPre " .. vim.fn.expand "~" .. "/Desktop/obi/**.md",
    "BufNewFile " .. vim.fn.expand "~" .. "/Desktop/obi/**.md",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "obi",
        path = "~/Desktop/obi",
      },
    },
    daily_notes = {
      folder = "notes/dailies",
      date_format = "%d-%m-%Y",
      default_tags = { "daily-notes" },
    },
  },
}
