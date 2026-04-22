--tandalone plugins with less than 10 lines of config go here
return {
  -- allow images to be rendered in the terminal
  -- {
  --   "folke/snacks.nvim",
  --   ---@type snacks.Config
  --   opts = {
  --     image = {
  --       doc = { inline = false },
  --       math = { enabled = false },
  --     },
  --   },
  -- },
  {
    -- basic setup for latex
    "lervag/vimtex",
    ft = "tex",
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_compiler_method = "latexmk"

      vim.keymap.set("n", "<leader>ll", ":VimtexCompile<CR>", { desc = "vimtex-compile" })
      vim.keymap.set("n", "<leader>lc", ":VimtexCompile<CR>", { desc = "vimtex-clean-aux" })
    end,
  },
  {
    "kaarmu/typst.vim",
    config = function()
      local typst_watch_job = nil

      vim.keymap.set("n", "<leader>tw", function()
        local file = vim.fn.expand("%:p") -- Get the full path of the current file
        if file == "" then
          print("No file name detected.")
          return
        end

        if typst_watch_job then
          vim.fn.jobstop(typst_watch_job) -- Stop the running job
          print("Stopped typst watch on " .. file)
          typst_watch_job = nil
        else
          typst_watch_job = vim.fn.jobstart({ "typst", "watch", file }, { detach = true })
          print("Started typst watch on " .. file)
        end
      end, { desc = "Toggle Typst watch on current file" })
    end,
  },
  {
    -- Tmux & split window navigation
    "christoomey/vim-tmux-navigator",
  },
  {
    -- Detect tabstop and shiftwidth automatically
    "tpope/vim-sleuth",
  },
  {
    -- Powerful Git integration for Vim
    "tpope/vim-fugitive",
  },
  {
    -- High-performance color highlighter
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },
  -- search functionality
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
  },
}
