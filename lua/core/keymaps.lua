local k = vim.keymap

-- Non-leader --
--
-- Window navigation
k.set("n", "<C-k>", ":wincmd k<CR>")
k.set("n", "<C-j>", ":wincmd j<CR>")
k.set("n", "<C-h>", ":wincmd h<CR>")
k.set("n", "<C-l>", ":wincmd l<CR>")

-- NvimTree toggle
k.set("n", "<C-n>", ":NvimTreeToggle<CR>")

-- Inlay hint toggle
k.set("n", "<C-i>", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end)

-- Copy, Paste, Undo, Redo
k.set("n", "<C-s>", ":write<CR>", { silent = true, desc = "Save" })
k.set("v", "<C-c>", '"+y', { silent = true, desc = "Copy to clipboard" })
k.set("n", "<C-v>", '"+p', { silent = true, desc = "Paste from clipboard" })
k.set("i", "<C-v>", "<C-r>+", { silent = true, desc = "Paste from clipboard" })
k.set("v", "<C-x>", '"+d', { silent = true, desc = "Cut to clipboard" })
k.set("n", "<C-z>", "u", { silent = true, desc = "Undo" })
k.set("i", "<C-z>", "<C-o>u", { silent = true, desc = "Undo" })
k.set("n", "<C-y>", "<C-r>", { silent = true, desc = "Redo" })
k.set("i", "<C-y>", "<C-o><C-r>", { silent = true, desc = "Redo" })

-- Leader --
--
k.set("n", "<leader>gb", ":GitBlameToggle<CR>", { desc = "Git blame toggle" })
k.set("n", "<leader>ws", ":ToggleWhitespace<CR>", { desc = "White space toggle" })
k.set("n", "<leader>to", ":tabnew<CR>", { desc = "New tab" })
k.set("n", "<leader>tx", ":tabclose<CR>", { desc = "Close tab" })
k.set("n", "<leader>tn", ":tabn<CR>", { desc = "Next tab" })
k.set("n", "<leader>tp", ":tabp<CR>", { desc = "Previous tab" })
k.set("v", "<leader>si", ":sort i<CR>", { desc = "Sort lines" })
local t = require "telescope.builtin"
k.set("n", "<leader>fd", ":Telescope diagnostics<CR>", { desc = "Telescope diagnostics" })
k.set("n", "<leader>ff", t.find_files, { desc = "Find files" })
k.set("n", "<leader>fg", t.live_grep, { desc = "Live grep" })
k.set("n", "<leader>fb", t.buffers, { desc = "Switch buffers" })
k.set("n", "<leader>fh", t.help_tags, { desc = "Help tags" })
k.set("n", "<leader>fu", t.current_buffer_fuzzy_find, { desc = "Find in current buffer" })
k.set("n", "<leader>fo", t.lsp_document_symbols, { desc = "LSP symbols" })
k.set("n", "<leader>fi", t.lsp_incoming_calls, { desc = "LSP incoming calls" })

-- LSP related stuff
k.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
k.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Refactor rename" })
k.set({ "n", "v" }, "<leader>ct", vim.lsp.buf.code_action, { desc = "Available code actions" })
k.set("n", "gr", vim.lsp.buf.references, { desc = "Find all references" })
