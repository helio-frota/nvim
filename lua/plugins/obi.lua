return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
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
