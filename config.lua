lvim.log.level = "warn"
lvim.format_on_save = false
lvim.colorscheme = "onedarker"
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

lvim.leader = "space"
vim.cmd("tnoremap <Esc> <C-\\><c-n>")
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.builtin.which_key.mappings["j"] = {
  name = "Custom Command",
  r = { "<cmd>MarkdownPreview<cr>", "MarkdownPreview" },
  s = { "<cmd>:MarkdownPreviewStop<cr>", "MarkdownPreviewStop" },
  d = { "<cmd>:DiffviewOpen<cr>", "DiffviewOpen" },
  c = { "<cmd>:DiffviewClose<cr>", "DiffviewClose" },
  p = { "<cmd>:Telescope projects<cr>", "Projects" },
  t = { "<cmd>:ToggleTerm size=20 dir=git_dir direction=horizontal<cr>", "ToggleTerm Horizontal" },
  T = { "<cmd>:ToggleTerm size=40 dir=git_dir direction=vertical<cr>", "ToggleTerm Vertical" },
}

lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "black", filetypes = { "python" } },
  { command = "isort", filetypes = { "python" } },
}

-- set additional linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "flake8", filetypes = { "python" } },
  {
    command = "shellcheck",
    extra_args = { "--severity warning", "--line-width 120" },
  },
}

lvim.plugins = {
  -- colorscheme
  {'shaeinst/roshnivim-cs'},
  {
    "sindrets/diffview.nvim",
    event = "BufRead",
  },
  { "Pocco81/auto-save.nvim",
      config = function()
        require("auto-save").setup {
          -- your config goes here
	  -- or just leave it empty :)
	}
      end,
  },
  {
    "sindrets/diffview.nvim",
    event = "BufRead",
  },
  {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    ft = "markdown",
    config = function()
      vim.g.mkdp_auto_start = 1
    end,
  },
  {
    "nvim-telescope/telescope-project.nvim",
    event = "BufWinEnter",
    setup = function()
      vim.cmd [[packadd telescope.nvim]]
    end,
  },
  { "zbirenbaum/copilot.lua",
    event = { "VimEnter" },
    config = function()
      vim.defer_fn(function()
        require("copilot").setup {
	        plugin_manager_path = get_runtime_dir() .. "/site/pack/packer",
        }
      end, 100)
    end,
  },
  { "zbirenbaum/copilot-cmp",
    after = { "copilot.lua", "nvim-cmp" },
  },
}

-- Can not be placed into the config method of the plugins.
lvim.builtin.cmp.formatting.source_names["copilot"] = "(Copilot)"
table.insert(lvim.builtin.cmp.sources, 1, { name = "copilot" })
