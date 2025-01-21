local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.cmd [[colorscheme tp]]

vim.opt.conceallevel = 1

require("lazy").setup {
  spec = {
    { import = "plugins" },
  },
  checker = { enabled = true },
}

require "core.options"
require "core.keymaps"
