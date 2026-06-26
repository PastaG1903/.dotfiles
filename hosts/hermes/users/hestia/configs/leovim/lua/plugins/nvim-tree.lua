return {
  "kyazdani42/nvim-tree.lua",
  dependencies = {
    {
     "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font
    },
  },
  config = function()
    local api = require("nvim-tree")
    api.setup({
      disable_netrw = true,
      hijack_netrw = true,
      git = {
        ignore = false, -- Disable gitignore filtering,
      },
      -- Renderer settings (for customizing how the tree looks)
      renderer = {
        icons = {
          glyphs = {
            default = "", -- Default file icon
            symlink = "", -- Symlink icon
            git = {
              unstaged = "", -- Git unstaged files
              staged = "✓", -- Git staged files
              untracked = "★", -- Git untracked files
            },
          },
        },
      },
    })

    vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true }) -- focus file explorer
  end,
}
