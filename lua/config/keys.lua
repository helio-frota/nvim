local map = vim.keymap.set

map("n", "<C-k>", "<C-w><C-k>")
map("n", "<C-j>", "<C-w><C-j>")
map("n", "<C-h>", "<C-w><C-h>")
map("n", "<C-l>", "<C-w><C-l>")

map("n", "<left>", ":bp<cr>")
map("n", "<right>", ":bn<cr>")

map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Toggle
map("n", "<C-i>", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end)

-- Buffer delete
map("n", "<C-ESC>", ":bd<CR>")
-- File delete
map("n", "<S-Delete>", ":!rm %<CR>:bd!<CR>", { noremap = true, silent = true })
-- Open nvim terminal
map("n", "<F2>", function()
  vim.cmd "botright split term://$SHELL"
end, { desc = "Terminal" })

-- Copy, Paste, Undo, Redo, Select all, Join lines
map("v", "<C-c>", '"+y', { silent = true })
map("n", "<C-v>", '"+p')
map("i", "<C-v>", "<C-r>+")
map("v", "<C-x>", '"+d')
map("n", "<C-z>", "u")
map("i", "<C-z>", "<C-o>u")
map("n", "<C-y>", "<C-r>")
map("i", "<C-y>", "<C-o><C-r>")
map("n", "<C-a>", "ggVG", { noremap = true })
map("n", "J", "mzJ`z")

-- Leader ----------
map(
  "n",
  "<leader>q",
  vim.diagnostic.setloclist,
  { desc = "Quickfix diagnostic list" }
)
map("v", "<leader>si", ":sort i<CR>", { desc = "Sort lines" })
map("n", "<leader>tb", ":GitBlameToggle<CR>", { desc = "Toggle blame" })

-- toggle aerial -------
map("n", "<leader>a", "<cmd>AerialToggle!<CR>")
local t = require "telescope.builtin"

map("n", "<leader>sk", t.keymaps, { desc = "Search keymaps" })
map("n", "<leader>sf", t.find_files, { desc = "Search files" })
map("n", "<leader>sw", t.grep_string, { desc = "Search current Word" })
map("n", "<leader>sg", t.live_grep, { desc = "Search by grep" })
map("n", "<leader>sd", t.diagnostics, { desc = "Search diagnostics" })
map("n", "<leader>s.", t.oldfiles, { desc = "Recent files" })

local ho = require "pretty_hover"
map("n", "K", function()
  ho.hover()
end, { desc = "[LSP]Show docs" })

map("n", "<leader>lf", function()
  t.lsp_references {
    fname_width = 60,
  }
end, { desc = "[LSP]Show refs" })

map(
  { "n", "v" },
  "<leader>la",
  vim.lsp.buf.code_action,
  { desc = "[LSP] Code actions" }
)

map("n", "<leader>rn", function()
  vim.lsp.buf.rename()
end, { desc = "[LSP]Rename" })

map("n", "gd", function()
  vim.lsp.buf.definition()
end, { desc = "[LSP]Go to def" })

map("n", "gi", function()
  vim.lsp.buf.implementations()
end, { desc = "[LSP]Go to Implementation" })

local minifiles = require "mini.files"
map("n", "<leader>e", function()
  minifiles.open(vim.api.nvim_buf_get_name(0))
  minifiles.reveal_cwd()
end, { desc = "Open Mini Files" })

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    if package.loaded["mini.trailspace"] then
      require("mini.trailspace").trim()
    end
  end,
})

