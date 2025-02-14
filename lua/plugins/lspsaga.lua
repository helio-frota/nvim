return {
  "nvimdev/lspsaga.nvim",
  config = function()
    require("lspsaga").setup {
      lightbulb = {
        enable = false,
      },
    }

    local keymap = vim.keymap.set
    keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { desc = "[LSP]Show docs" })
    keymap("n", "<leader>lf", "<cmd>Lspsaga finder<CR>", { desc = "[LSP]Show refs" })
    keymap("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { desc = "[LSP]Code actions" })
    keymap("v", "<leader>ca", "<cmd>Lspsaga range_code_action<CR>", { desc = "[LSP]Code actions (range)" })
    keymap("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", { desc = "[LSP]Rename" })
    keymap("n", "<leader>de", "<cmd>Lspsaga show_line_diagnostics<CR>", { desc = "[LSP]Show diags" })
    keymap("n", "gd", "<cmd>Lspsaga goto_definition<CR>", { desc = "[LSP]Go to def" })
    keymap("n", "gi", "<cmd>Lspsaga goto_implementation<CR>", { desc = "[LSP]Go to impl" })
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
}
