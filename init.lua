-- Bootstrap lazy
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- This has to be set before initializing lazy
vim.g.mapleader = " "
vim.cmd [[colorscheme tp]]

local lazy_config = require "core.lazy"

-- Initialize lazy with dynamic loading of anything in the plugins directory
require("lazy").setup("plugins", {
  change_detection = {
    enabled = true, -- auto check for config file changes and reload the UI
    notify = false, -- turn off notifications whenever plugin changes are made
  },
}, lazy_config)

-- These modules are not loaded by lazy
require "core.options"
require "core.keymaps"
