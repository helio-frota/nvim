return {
  "jellydn/hurl.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  ft = "hurl",
  opts = {
    debug = false,
    show_notification = false,
    mode = "split",
    formatters = {
      json = { "jq" },
    },
    mappings = {
      close = "q",
      next_panel = "<C-n>",
      prev_panel = "<C-p>",
    },
  },
  keys = {
    { "<leader>A", "<cmd>HurlRunner<CR>", desc = "[HURL] Run All requests" },
    { "<leader>a", "<cmd>HurlRunnerAt<CR>", desc = "[HURL] Run Api request" },
    {
      "<leader>te",
      "<cmd>HurlRunnerToEntry<CR>",
      desc = "[HURL] Run Api request to entry",
    },
    {
      "<leader>tE",
      "<cmd>HurlRunnerToEnd<CR>",
      desc = "[HURL] Run Api request from current entry to end",
    },
    {
      "<leader>tm",
      "<cmd>HurlToggleMode<CR>",
      desc = "[HURL] Hurl Toggle Mode",
    },
    {
      "<leader>tv",
      "<cmd>HurlVerbose<CR>",
      desc = "[HURL] Run Api in verbose mode",
    },
    {
      "<leader>tV",
      "<cmd>HurlVeryVerbose<CR>",
      desc = "[HURL] Run Api in very verbose mode",
    },
    {
      "<leader>h",
      ":HurlRunner<CR>",
      desc = "[HURL] Hurl Runner",
      mode = "v",
    },
  },
  config = function()
    require("hurl").setup {}
  end,
}
