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
        },
      }
    end,
  },
  {
    "Fildo7525/pretty_hover",
    event = "LspAttach",
    opts = {},
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
      completion = {
        documentation = {
          auto_show = true,
        },
      },
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
      require("mason").setup {
        PATH = "append",
      }
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
    config = function() end,
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
          standalone = false,
          ["rust-analyzer"] = {
            files = {
              exclude = {
                "target/",
                ".git",
              },
            },
            procMacro = {
              enable = true,
            },
            cargo = {
              features = "all",
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
            inlayHints = {
              lifetimeElisionHints = {
                enable = true,
                useParameterNames = true,
              },
            },
          },
        },
      },
    },
  },
  -- the awesome mini
  {
    "echasnovski/mini.nvim",
    config = function()
      require("mini.align").setup()
      require("mini.basics").setup()
      require("mini.comment").setup()
      require("mini.cursorword").setup()
      require("mini.diff").setup()
      require("mini.extra").setup()
      require("mini.files").setup()
      require("mini.git").setup()
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
  {
    "towolf/vim-helm",
  },
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
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
    opts = {
      render_modes = { "n", "c", "t" },
    },
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function(plugin)
      if vim.fn.executable "npx" then
        vim.cmd("!cd " .. plugin.dir .. " && cd app && npx --yes yarn install")
      else
        vim.cmd [[Lazy load markdown-preview.nvim]]
        vim.fn["mkdp#util#install"]()
      end
    end,
    init = function()
      if vim.fn.executable "npx" then
        vim.g.mkdp_filetypes = { "markdown" }
      end
    end,
    keys = {
      {
        "<leader>mp",
        ft = "markdown",
        "<cmd>MarkdownPreviewToggle<cr>",
        desc = "Markdown Preview",
      },
    },
  },
  {
    "stevearc/aerial.nvim",
    opts = {
      show_guides = true,
      layout = {
        min_width = 20,
      },
    },
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    "stevearc/stickybuf.nvim",
    opts = {},
  },
  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },

  {

    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
      require("tiny-inline-diagnostic").setup {
        hi = {
          error = "DiagnosticError",
          warn = "DiagnosticWarn",
          info = "DiagnosticInfo",
          hint = "DiagnosticHint",
          arrow = "NonText",
          background = "CursorLine",
        },
        transparent_bg = true,
        options = {
          use_icons_from_diagnostic = true,
          throttle = 0,
          enable_on_insert = true,
          show_all_diags_on_cursorline = true,
        },
      }
    end,
  },

  {
    "letorbi/vim-colors-modern-borland",
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

k.set("v", "<", "<gv", { desc = "Indent left" })
k.set("v", ">", ">gv", { desc = "Indent right" })

-- Toggle
k.set("n", "<C-i>", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end)

-- Buffer delete
k.set("n", "<C-ESC>", ":bd<CR>")
-- File delete
k.set("n", "<S-Delete>", ":!rm %<CR>:bd!<CR>", { noremap = true, silent = true })
-- Open nvim terminal
k.set("n", "<F2>", function()
  vim.cmd "botright split term://$SHELL"
end, { desc = "Terminal" })

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

-- toggle aerial -------
k.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")
local t = require "telescope.builtin"

k.set("n", "<leader>sk", t.keymaps, { desc = "Search keymaps" })
k.set("n", "<leader>sf", t.find_files, { desc = "Search files" })
k.set("n", "<leader>sw", t.grep_string, { desc = "Search current Word" })
k.set("n", "<leader>sg", t.live_grep, { desc = "Search by grep" })
k.set("n", "<leader>sd", t.diagnostics, { desc = "Search diagnostics" })
k.set("n", "<leader>s.", t.oldfiles, { desc = "Recent files" })

local ho = require "pretty_hover"
k.set("n", "K", function()
  ho.hover()
end, { desc = "[LSP]Show docs" })

k.set("n", "<leader>lf", function()
  t.lsp_references {
    fname_width = 60,
  }
end, { desc = "[LSP]Show refs" })

k.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, { desc = "[LSP] Code actions" })

k.set("n", "<leader>rn", function()
  vim.lsp.buf.rename()
end, { desc = "[LSP]Rename" })

k.set("n", "gd", function()
  vim.lsp.buf.definition()
end, { desc = "[LSP]Go to def" })

vim.keymap.set("n", "gi", function()
  vim.lsp.buf.implementations()
end, { desc = "[LSP]Go to Implementation" })

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

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    if package.loaded["mini.trailspace"] then
      require("mini.trailspace").trim()
    end
  end,
})

-- To change the colorscheme:
-- 1) Comment the global variable that is specific to the `letorbi/vim-colors-modern-borland` plugin
-- 2) Change the colorscheme using one of these: `borland` (Turbo Pascal) - `tp` (old textpad) - `ec` (Eclipse IDE 2.1) - `ec36` (Eclipse IDE 3.6 Helios) - `ij` (Intellij IDEA 11.1.5)
-- vim.g.BorlandStyle = "modern"
vim.cmd [[colorscheme ec]]
