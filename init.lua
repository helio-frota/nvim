-- leader -> space
vim.g.mapleader = " "

-- I created a minimal colorscheme based on old textpad inspired by
-- this work: https://github.com/damc-code/vscode-theme-geal
-- nvim automatically looks for a colorscheme in `colors` directory
vim.cmd [[colorscheme tp]]

-- options
local o = vim.opt

o.background = "light"
o.backup = false
o.breakindent = true
o.clipboard = "unnamedplus"
o.conceallevel = 1
o.cmdheight = 0
o.cursorline = true
o.expandtab = true
o.foldenable = false
o.foldmethod = "manual"
o.hlsearch = false
o.ignorecase = true
o.incsearch = true
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
o.termguicolors = true
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
  -- not sure if this is true
  performance = {
    rtp = {
      disabled_plugins = {
        "2html_plugin",
        "tohtml",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "matchit",
        "tar",
        "tarPlugin",
        "rrhelper",
        "spellfile_plugin",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
        "tutor",
        "rplugin",
        "syntax",
        "synmenu",
        "optwin",
        "compiler",
        "bugreport",
        "ftplugin",
      },
    },
  },
  -- lua style
  {
    "wesleimp/stylua.nvim",
  },
  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    build = ":TSUpdate",
    config = function()
      local configs = require "nvim-treesitter.configs"
      configs.setup {
        ensure_installed = { "lua", "rust" },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
        auto_install = true,
      }
      require("vim.treesitter.query").set(
        "markdown",
        "highlights",
        "(fenced_code_block_delimiter) @punctuation.bracket"
      )
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
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
    },
    config = function()
      local cmp = require "cmp"

      cmp.setup {
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        mapping = cmp.mapping.preset.insert {
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete {},
          ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { "i", "s" }),
        },
        sources = cmp.config.sources {
          {
            name = "nvim_lsp",
            entry_filter = function(entry, _)
              return require("cmp").lsp.CompletionItemKind.Snippet ~= entry:get_kind()
            end,
          },
          { name = "buffer" },
          { name = "path" },
        },
        window = {
          documentation = cmp.config.window.bordered {
            winhighlight = "Normal:CmpPmenu,FloatBorder:CmpBorder",
          },
          completion = cmp.config.window.bordered {
            winhighlight = "Normal:CmpPmenu,FloatBorder:CmpBorder",
          },
        },
      }
    end,
  },
  -- LSP stuff
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup {
        ensure_installed = { "lua_ls", "taplo" },
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    },
    lazy = false,
    config = function(_, opts)
      local signs = { ERROR = "", WARN = "", INFO = "", HINT = "" }
      local diagnostic_signs = {}
      for type, icon in pairs(signs) do
        diagnostic_signs[vim.diagnostic.severity[type]] = icon
      end

      vim.diagnostic.config {
        signs = { text = diagnostic_signs },
        virtual_text = false,
        float = {
          source = "always",
          border = "rounded",
        },
        severity_sort = true,
        virtual_lines = { highlight_whole_line = false },
      }

      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require "lspconfig"
      lspconfig.lua_ls.setup {
        capabilities = capabilities,
      }

      lspconfig.rust_analyzer.setup {
        settings = {
          ["rust-analyzer"] = {
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
            cargo = {
              allFeatures = true,
            },
            imports = {
              group = {
                enable = false,
              },
            },
            completion = {
              postfix = {
                enable = false,
              },
            },
          },
        },
      }

      opts.diagnostics = {
        float = {
          border = "rounded",
        },
      }
    end,
  },
  {
    "rust-lang/rust.vim",
    ft = { "rust" },
    config = function() end,
  },
  -- NOTE: switch to rustaceanvim in case any weird thing happen
  -- {
  --     "mrcjkb/rustaceanvim",
  --     lazy = false,
  --     ft = { "rust" },
  --     config = function(_, opts)
  --         vim.g.rustaceanvim = vim.tbl_deep_extend("force", {}, opts or {})
  --     end,
  --     opts = {
  --         server = {
  --             settings = {
  --                 ["rust-analyzer"] = {
  --                     check = {
  --                         command = "clippy",
  --                         extraArgs = {
  --                             "--",
  --                             "-D",
  --                             "warnings",
  --                             "-D",
  --                             "clippy::unwrap_used",
  --                             "-D",
  --                             "clippy::expect_used",
  --                             "--no-deps",
  --                         },
  --                     },
  --                 },
  --             },
  --         },
  --     },
  -- },
  {
    "nvimdev/lspsaga.nvim",
    config = function()
      require("lspsaga").setup {
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
      require("mini.comment").setup()
      require("mini.cursorword").setup()
      require("mini.files").setup()
      require("mini.git").setup()
      require("mini.icons").setup()
      require("mini.move").setup()
      require("mini.notify").setup()
      require("mini.pairs").setup()
      require("mini.starter").setup()
      require("mini.tabline").setup()
      require("mini.trailspace").setup()
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
  --- git support TODO: review this
  -- {
  --   "lewis6991/gitsigns.nvim",
  --   opts = {
  --     on_attach = function(bufnr)
  --       local gitsigns = require "gitsigns"
  --
  --       local function map(mode, l, r, opts)
  --         opts = opts or {}
  --         opts.buffer = bufnr
  --         vim.keymap.set(mode, l, r, opts)
  --       end
  --
  --       map("n", "]c", function()
  --         if vim.wo.diff then
  --           vim.cmd.normal { "]c", bang = true }
  --         else
  --           gitsigns.nav_hunk "next"
  --         end
  --       end, { desc = "Jump to next git change" })
  --
  --       map("n", "[c", function()
  --         if vim.wo.diff then
  --           vim.cmd.normal { "[c", bang = true }
  --         else
  --           gitsigns.nav_hunk "prev"
  --         end
  --       end, { desc = "Jump to previous git change" })
  --
  --       map("v", "<leader>hs", function()
  --         gitsigns.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
  --       end, { desc = "git stage hunk" })
  --       map("v", "<leader>hr", function()
  --         gitsigns.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
  --       end, { desc = "git reset hunk" })
  --       map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "git stage hunk" })
  --       map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "git reset hunk" })
  --       map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "git Stage buffer" })
  --       map("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "git undo stage hunk" })
  --       map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "git Reset buffer" })
  --       map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "git preview hunk" })
  --       map("n", "<leader>hb", gitsigns.blame_line, { desc = "git blame line" })
  --       map("n", "<leader>hd", gitsigns.diffthis, { desc = "git diff against index" })
  --       map("n", "<leader>hD", function()
  --         gitsigns.diffthis "@"
  --       end, { desc = "git diff against last commit" })
  --       -- Toggles
  --       map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Toggle git blame" })
  --       map("n", "<leader>tD", gitsigns.toggle_deleted, { desc = "Toggle git deleted" })
  --     end,
  --     signs = { -- TODO: day to day only this part helps me, the signs. I'll remove this probably
  --       add = { text = "+" },
  --       change = { text = "~" },
  --       delete = { text = "_" },
  --       topdelete = { text = "‾" },
  --       changedelete = { text = "~" },
  --     },
  --   },
  -- },
  -- scroll bar
  {
    "dstein64/nvim-scrollview",
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
      { "<leader>tE", "<cmd>HurlRunnerToEnd<CR>", desc = "[HURL] un Api request from current entry to end" },
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

local t = require "telescope.builtin"

k.set("n", "<leader>sh", t.help_tags, { desc = "Search Help" })
k.set("n", "<leader>sc", t.git_bcommits, { desc = "Search git commits" })
k.set("n", "<leader>sk", t.keymaps, { desc = "Search Keymaps" })
k.set("n", "<leader>sf", t.find_files, { desc = "Search Files" })
k.set("n", "<leader>ss", t.builtin, { desc = "Search Select Telescope" })
k.set("n", "<leader>sw", t.grep_string, { desc = "Search current Word" })
k.set("n", "<leader>sg", t.live_grep, { desc = "Search by Grep" })
k.set("n", "<leader>sd", t.diagnostics, { desc = "Search Diagnostics" })
k.set("n", "<leader>sr", t.resume, { desc = "Search Resume" })
k.set("n", "<leader>s.", t.oldfiles, { desc = 'Search Recent Files ("." for repeat)' })
k.set("n", "<leader><leader>", t.buffers, { desc = "Find existing buffers" })

-- lsp saga
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
