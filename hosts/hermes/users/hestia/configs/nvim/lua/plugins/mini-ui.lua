return {
  -- greeter
  -- {
  --   "echasnovski/mini.starter",
  --   version = false,
  --   config = function()
  --     local api = require("mini.starter")
  --     api.setup({
  --       header = table.concat({
  --         [[██╗     ███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗]],
  --         [[██║     ██╔════╝██╔═══██╗██║   ██║██║████╗ ████║]],
  --         [[██║     █████╗  ██║   ██║██║   ██║██║██╔████╔██║]],
  --         [[██║     ██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
  --         [[███████╗███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║]],
  --         [[╚══════╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
  --       }, "\n"),
  --       items = {
  --         api.sections.builtin_actions(),
  --       },
  --     })
  --   end,
  -- },
  -- top buffers in a tabline
  {
    "echasnovski/mini.tabline",
    dependencies = { "echasnovski/mini.icons", version = false },
    version = false,
    config = function()
      local tabline = require("mini.tabline")
      tabline.setup({
        show_icons = true,
        set_vim_settins = true,
      })
    end,
  },

  -- statusline
  {
    "echasnovski/mini.statusline",
    version = false,
    config = function()
      local statusline = require("mini.statusline")
      -- statusline.setup()

      statusline.setup({
        -- Content for each section
        content = {
          active = function()
            local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
            local git = statusline.section_git({ trunc_width = 40 })
            local diff = statusline.section_diff({ trunc_width = 75 })
            local diagnostics = statusline.section_diagnostics({ trunc_width = 75 })
            local lsp = statusline.section_lsp({ trunc_width = 75 })
            local filename = statusline.section_filename({ trunc_width = 140 })
            local fileinfo = statusline.section_fileinfo({ trunc_width = 120 })
            local location = statusline.section_location({ trunc_width = 75 })
            local search = statusline.section_searchcount({ trunc_width = 75 })

            return statusline.combine_groups({
              -- Mode section with a proper label
              { hl = mode_hl, strings = { mode } },
              -- { hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics, lsp } },
              { hl = "MiniStatuslineDevinfo", strings = { git } },
              "%<", -- Mark general truncate point
              { hl = "MiniStatuslineFilename", strings = { filename } },
              "%=", -- End left alignment
              { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
              -- { hl = mode_hl, strings = { location } },
              { hl = "MiniStatuslineLocation", strings = { location } },
              { hl = mode_hl, strings = { vim.fn.strftime("%H:%M") } },
            })
          end,
          inactive = nil, -- Use default for inactive
        },
        -- Enable icons and automatic statusline adjustments
        use_icons = true,
        set_vim_settings = true,
      })

    end,
  },
}
