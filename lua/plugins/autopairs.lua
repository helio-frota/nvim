-- Auto-completion of bracket/paren/quote pairs
return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = {
    check_ts = true, -- enable treesitter
  },
}
