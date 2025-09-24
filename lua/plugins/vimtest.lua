return {
  "vim-test/vim-test",
  dependencies = { "tpope/vim-dispatch" },
  init = function()
    local map = vim.keymap.set
    map("n", "<leader>tt", "<cmd>TestNearest<cr>", { desc = "Test nearest" })
    map("n", "<leader>tf", "<cmd>TestFile<cr>", { desc = "Test file" })
    map("n", "<leader>tl", "<cmd>TestLast<cr>", { desc = "Test last" })
  end,
}
