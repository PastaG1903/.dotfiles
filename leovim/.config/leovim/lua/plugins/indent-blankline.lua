return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {
    indent = {
      char = "▏",
    },
    scope = {
      enabled = true,
      show_start = false,
      show_end = false,
      show_exact_scope = false,
      -- highlight = "IndentBlanklineScope", -- Set the highlight group for the current scope
    },
    exclude = {
      filetypes = {
        "help",
        "startify",
        "dashboard",
        "packer",
        "neogitstatus",
        "NvimTree",
        "Trouble",
      },
    },
  },
  -- vim.api.nvim_set_hl(0, "IndentBlanklineScope", { fg = "#1bbae4", bold = true })
}
