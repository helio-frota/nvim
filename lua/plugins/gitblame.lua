return {
  "f-person/git-blame.nvim",
  event = "VeryLazy",
  opts = {
    enabled = false,
    message_template = " <author>-<summary>•<date>",
    date_format = "%d-%m-%Y %H:%M:%S",
    virtual_text_column = 1,
  },
}
