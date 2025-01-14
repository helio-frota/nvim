local k = vim.keymap

-- Non-leader ----------

-- Navigation
k.set("n", "<C-k>", "<C-w><C-k>")
k.set("n", "<C-j>", "<C-w><C-j>")
k.set("n", "<C-h>", "<C-w><C-h>")
k.set("n", "<C-l>", "<C-w><C-l>")

k.set("n", "<left>", '<cmd>echo "Use h to move 󱗗"<CR>')
k.set("n", "<right>", '<cmd>echo "Use l to move 󱗗"<CR>')
k.set("n", "<up>", '<cmd>echo "Use k to move 󱗗"<CR>')
k.set("n", "<down>", '<cmd>echo "Use j to move 󱗗"<CR>')

-- Toggle
k.set("n", "<C-n>", ":NvimTreeToggle<CR>")
k.set("n", "<C-i>", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end)

-- Copy, Paste, Undo, Redo, Select all, Join lines
k.set("n", "<C-s>", ":write<CR>")
k.set("v", "<C-c>", '"+y', { silent = true })
k.set("n", "<C-v>", '"+p')
k.set("i", "<C-v>", "<C-r>+")
k.set("v", "<C-x>", '"+d')
k.set("n", "<C-z>", "u")
k.set("i", "<C-z>", "<C-o>u")
k.set("n", "<C-y>", "<C-r>")
k.set("i", "<C-y>", "<C-o><C-r>")
k.set("n", "<C-a>", "ggVG", { noremap = true })
k.set("n", "J", "mzJ`z")

-- Leader ----------
k.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
k.set("n", "<leader>gb", ":GitBlameToggle<CR>", { desc = "Git blame toggle" })
k.set("n", "<leader>to", ":tabnew<CR>", { desc = "New tab" })
k.set("n", "<leader>tx", ":tabclose<CR>", { desc = "Close tab" })
k.set("n", "<leader>tn", ":tabn<CR>", { desc = "Next tab" })
k.set("n", "<leader>tp", ":tabp<CR>", { desc = "Previous tab" })
k.set("v", "<leader>si", ":sort i<CR>", { desc = "Sort lines" })

local t = require "telescope.builtin"

k.set("n", "<leader>sh", t.help_tags, { desc = "[S]earch [H]elp" })
k.set("n", "<leader>sk", t.keymaps, { desc = "[S]earch [K]eymaps" })
k.set("n", "<leader>sf", t.find_files, { desc = "[S]earch [F]iles" })
k.set("n", "<leader>ss", t.builtin, { desc = "[S]earch [S]elect Telescope" })
k.set("n", "<leader>sw", t.grep_string, { desc = "[S]earch current [W]ord" })
k.set("n", "<leader>sg", t.live_grep, { desc = "[S]earch by [G]rep" })
k.set("n", "<leader>sd", t.diagnostics, { desc = "[S]earch [D]iagnostics" })
k.set("n", "<leader>sr", t.resume, { desc = "[S]earch [R]esume" })
k.set("n", "<leader>s.", t.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
k.set("n", "<leader><leader>", t.buffers, { desc = "[ ] Find existing buffers" })

-- Obsidian
k.set("n", "<leader>on", ":ObsidianNew", { desc = "New obsidian note" })
k.set("n", "<leader>os", ":ObsidianSearch", { desc = "Search notes" })
k.set("n", "<leader>ot", ":ObsidianTags", { desc = "List tags" })
k.set("n", "<leader>oqs", ":ObsidianQuickSwitch", { desc = "Quick switch to other note" })
k.set("n", "<leader>ont", ":ObsidianToday", { desc = "Today daily note" })
k.set("n", "<leader>ony", ":ObsidianYesterday", { desc = "Yesterday daily note" })
k.set("n", "<leader>ond", ":ObsidianDailies", { desc = "List daily notes" })
