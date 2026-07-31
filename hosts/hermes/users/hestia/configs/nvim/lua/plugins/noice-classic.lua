-- some ui aesthetic changes
-- notification messages
-- cmd line in the middle
return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    cmdline = {
      view = "cmdline", -- classic cmdline view
    },
    presets = {
      bottom_search = true, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = false, -- add a border to hover docs and signature help
    },
    routes = {
      -- do not show written messages, they are annoying
      {
        filter = {
          event = "msg_show",
          kind = "",
          find = "written",
        },
        opts = { skip = true },
      },
      -- show @recording as notification
      {
        view = "notify",
        filter = { event = "msg_showmode" },
      },
    },
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
    {
      "rcarriga/nvim-notify",
      opts = {
        stages = "static", -- no animations
      },
    },
  },
}
