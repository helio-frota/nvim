-- leader -> space
vim.g.mapleader = " "
-- options
local o = vim.opt
o.autoread = true
o.autowrite = false
o.background = "light"
o.backup = false
o.backspace = "indent,eol,start"
o.breakindent = true
o.clipboard = "unnamedplus"
o.colorcolumn = "85"
-- https://doc.rust-lang.org/edition-guide/rust-2024/rustfmt-formatting-fixes.html
vim.api.nvim_create_autocmd(
  "Filetype",
  { pattern = "rust", command = "set colorcolumn=119" }
)
o.completeopt = "menuone,noinsert,noselect"
o.cmdheight = 0
o.conceallevel = 1
o.cursorline = true
o.expandtab = true
o.foldenable = false
o.foldmethod = "manual"
o.hlsearch = false
o.ignorecase = true
o.number = true
o.scrolloff = 8
o.shiftwidth = 4
o.signcolumn = "yes"
o.smartcase = true
o.smartindent = true
o.softtabstop = 4
o.spell = true
o.spelllang = "en_us"
o.swapfile = false
o.tabstop = 4
o.timeoutlen = 500
o.ttimeoutlen = 0
o.undofile = false
o.updatetime = 300
o.wrap = false
o.writebackup = false
