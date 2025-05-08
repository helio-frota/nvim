-- leader -> space
vim.g.mapleader = " "

-- I created a minimal colorscheme based on old textpad inspired by
-- this work: https://github.com/damc-code/vscode-theme-geal
-- nvim automatically looks for a colorscheme in `colors` directory
vim.cmd [[colorscheme tp]]

-- options
local o = vim.opt
o.backup = false
o.background = "light"
o.breakindent = true
o.clipboard = "unnamedplus"
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
o.timeoutlen = 300
o.updatetime = 250
o.wrap = false
o.writebackup = false

-- plugins
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
o.rtp:prepend(lazypath)

require("lazy").setup {
  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "lua" },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
      auto_install = true,
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  -- the format
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup {
        formatters_by_ft = {
          lua = { "stylua" },
          rust = { "rustfmt", lsp_format = "fallback" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_format = "fallback",
        },
      }
    end,
  },
  -- the completion
  {
    "saghen/blink.cmp",
    version = "1.*",
    opts = {
      keymap = {
        preset = "default",
        ["<CR>"] = { "accept", "fallback" },
        ["<C><leader>"] = { "show" },
      },
      completion = { documentation = { auto_show = true } },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
  },
  -- LSP stuff
  {
    "mason-org/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup {
        ensure_installed = { "lua_ls", "taplo" },
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function(_, _)
      vim.diagnostic.config {
        virtual_lines = true,
        severity_sort = true,
      }
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^6",
    lazy = false,
    ft = { "rust" },
    config = function(_, opts)
      vim.g.rustaceanvim = vim.tbl_deep_extend("force", {}, opts or {})
    end,
    opts = {
      server = {
        settings = {
          ["rust-analyzer"] = {
            files = {
              exclude = {
                "target",
                ".git",
              },
            },
            procMacro = {
              enable = true,
            },
            check = {
              command = "clippy",
              extraArgs = {
                "--",
                "-D",
                "warnings",
                "-D",
                "clippy::unwrap_used",
                "-D",
                "clippy::expect_used",
                "--no-deps",
              },
            },
          },
        },
      },
    },
  },
  {
    "nvimdev/lspsaga.nvim",
    config = function()
      require("lspsaga").setup {
        symbol_in_winbar = {
          enable = false,
        },
        lightbulb = {
          enable = false,
        },
      }
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
  -- the awesome mini
  {
    "echasnovski/mini.nvim",
    config = function()
      require("mini.align").setup()
      require("mini.animate").setup()
      require("mini.basics").setup()
      require("mini.comment").setup()
      require("mini.cursorword").setup()
      require("mini.diff").setup()
      require("mini.extra").setup()
      require("mini.files").setup()
      require("mini.git").setup()
      require("mini.icons").setup()
      require("mini.indentscope").setup()
      require("mini.move").setup()
      require("mini.notify").setup()
      require("mini.pairs").setup()
      require("mini.pick").setup()
      require("mini.starter").setup()
      require("mini.tabline").setup()
      require("mini.trailspace").setup()

      local misc = require "mini.misc"
      misc.setup_termbg_sync()
      local statusline = require "mini.statusline"
      statusline.setup { use_icons = true }
      statusline.section_location = function()
        return "%2l:%-2v"
      end
      local hipatterns = require "mini.hipatterns"
      hipatterns.setup {
        highlighters = {
          fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
          hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
          todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
          note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      }

      local minidiff = require "mini.diff"
      minidiff.setup {
        view = {
          style = "sign",
          signs = { add = "+", change = "~", delete = "-" },
        },
      }

      local miniclue = require "mini.clue"
      miniclue.setup {
        triggers = {
          { mode = "n", keys = "<Leader>" },
          { mode = "x", keys = "<Leader>" },
          { mode = "i", keys = "<C-x>" },
          { mode = "n", keys = "g" },
          { mode = "x", keys = "g" },
          { mode = "n", keys = "'" },
          { mode = "n", keys = "`" },
          { mode = "x", keys = "'" },
          { mode = "x", keys = "`" },
          { mode = "n", keys = '"' },
          { mode = "x", keys = '"' },
          { mode = "i", keys = "<C-r>" },
          { mode = "c", keys = "<C-r>" },
          { mode = "n", keys = "<C-w>" },
          { mode = "n", keys = "z" },
          { mode = "x", keys = "z" },
        },

        clues = {
          miniclue.gen_clues.builtin_completion(),
          miniclue.gen_clues.g(),
          miniclue.gen_clues.marks(),
          miniclue.gen_clues.registers(),
          miniclue.gen_clues.windows(),
          miniclue.gen_clues.z(),
        },
        window = {
          config = { width = "auto", anchor = "SE", row = "auto", col = "auto" },
        },
      }
    end,
  },
  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    branch = "0.1.x",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-ui-select.nvim" },
    },
  },
  -- crates support
  {
    "saecki/crates.nvim",
    config = function()
      require("crates").setup {}
    end,
  },
  -- {
  --   "cordx56/rustowl",
  --   version = "*",
  --   build = "cargo binstall rustowl",
  --   run = "rustowl",
  --   config = function()
  --     local lspconfig = require "lspconfig"
  --     lspconfig.config.rustowl.setup {}
  --   end,
  --   lazy = false,
  --   opts = {
  --     client = {
  --       on_attach = function(_, buffer)
  --         vim.keymap.set("n", "<leader>to", function()
  --           require("rustowl").toggle(buffer)
  --         end, { buffer = buffer, desc = "Toggle RustOwl" })
  --       end,
  --     },
  --   },
  -- },
  -- hurl support
  {
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
      { "<leader>te", "<cmd>HurlRunnerToEntry<CR>", desc = "[HURL] Run Api request to entry" },
      { "<leader>tE", "<cmd>HurlRunnerToEnd<CR>", desc = "[HURL] Run Api request from current entry to end" },
      { "<leader>tm", "<cmd>HurlToggleMode<CR>", desc = "[HURL] Hurl Toggle Mode" },
      { "<leader>tv", "<cmd>HurlVerbose<CR>", desc = "[HURL] Run Api in verbose mode" },
      { "<leader>tV", "<cmd>HurlVeryVerbose<CR>", desc = "[HURL] Run Api in very verbose mode" },
      { "<leader>h", ":HurlRunner<CR>", desc = "[HURL] Hurl Runner", mode = "v" },
    },
    config = function()
      require("hurl").setup {
        env_file = {
          "hurl.env",
        },
      }
    end,
  },
  -- helm-chart template syntax support
  -- {
  --   "towolf/vim-helm",
  -- },
  {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    opts = {
      enabled = false,
      message_template = " <author>-<summary>•<date>",
      date_format = "%m-%d-%Y %H:%M:%S",
      virtual_text_column = 1,
    },
  },
}

-- keymaps
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
k.set("n", "<C-i>", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end)

-- Buffer delete
k.set("n", "<C-ESC>", ":bd<CR>")
-- File delete
k.set("n", "<S-Delete>", ":!rm %<CR>:bd!<CR>", { noremap = true, silent = true })
-- toggle term
k.set("n", "<F2>", "<cmd>Lspsaga term_toggle<CR>")
k.set("t", "<F2>", "<cmd>Lspsaga term_toggle<CR>")

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
k.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Quickfix diagnostic list" })
k.set("v", "<leader>si", ":sort i<CR>", { desc = "Sort lines" })
k.set("n", "<leader>tb", ":GitBlameToggle<CR>", { desc = "Toggle blame" })

local t = require "telescope.builtin"

k.set("n", "<leader>sh", t.help_tags, { desc = "Search Help" })
k.set("n", "<leader>sk", t.keymaps, { desc = "Search Keymaps" })
k.set("n", "<leader>sf", t.find_files, { desc = "Search Files" })
k.set("n", "<leader>ss", t.builtin, { desc = "Search Select Telescope" })
k.set("n", "<leader>sw", t.grep_string, { desc = "Search current Word" })
k.set("n", "<leader>sg", t.live_grep, { desc = "Search by Grep" })
k.set("n", "<leader>sd", t.diagnostics, { desc = "Search diagnostics" })
k.set("n", "<leader>sr", t.resume, { desc = "Search resume" })
k.set("n", "<leader>s.", t.oldfiles, { desc = "Recent files" })

-- LSP saga
k.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { desc = "[LSP]Show docs" })
k.set("n", "<leader>lf", "<cmd>Lspsaga finder<CR>", { desc = "[LSP]Show refs" })
k.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { desc = "[LSP]Code actions" })
k.set("v", "<leader>ca", "<cmd>Lspsaga range_code_action<CR>", { desc = "[LSP]Code actions (range)" })
k.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", { desc = "[LSP]Rename" })
k.set("n", "<leader>de", "<cmd>Lspsaga show_line_diagnostics<CR>", { desc = "[LSP]Show diags" })
k.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>", { desc = "[LSP]Go to def" })
k.set("n", "gi", "<cmd>Lspsaga goto_implementation<CR>", { desc = "[LSP]Go to impl" })

local minifiles = require "mini.files"
k.set("n", "<leader>e", function()
  minifiles.open(vim.api.nvim_buf_get_name(0))
  minifiles.reveal_cwd()
end, { desc = "Open Mini Files" })

k.set("n", "<leader>cf", function()
  local dir = vim.fn.expand "%:h"
  local filename = vim.fn.input("New buffer: ", dir .. "/")
  if filename ~= "" then
    vim.cmd("e " .. filename)
  end
end, { desc = "New buffer here" })
