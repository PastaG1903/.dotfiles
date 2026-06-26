return {
  -- greeter
  {
    "echasnovski/mini.starter",
    version = false,
    config = function()
      local api = require("mini.starter")
      api.setup({
        header = table.concat({
          [[██╗     ███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗]],
          [[██║     ██╔════╝██╔═══██╗██║   ██║██║████╗ ████║]],
          [[██║     █████╗  ██║   ██║██║   ██║██║██╔████╔██║]],
          [[██║     ██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
          [[███████╗███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║]],
          [[╚══════╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
        }, "\n"),
        items = {
          api.sections.builtin_actions(),
        },
      })
    end,
  },
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

      -- local colors = require("onedarkpro.helpers").get_colors()
      -- Primary colors
      -- colors.bg           -- Background
      -- colors.bg_dark      -- Darker background
      -- colors.bg_highlight -- Highlighted background
      -- colors.fg           -- Foreground text
      -- colors.fg_dark      -- Darker foreground text
      -- colors.fg_gutter    -- Foreground for gutters
      -- colors.gray         -- Neutral gray

      -- Accent colors
      -- colors.blue         -- Primary accent (blue)
      -- colors.cyan         -- Cool accent (cyan)
      -- colors.green        -- Success/positive (green)
      -- colors.magenta      -- Pinkish purple (magenta)
      -- colors.orange       -- Warning/accent (orange)
      -- colors.purple       -- Rich purple
      -- colors.red          -- Error/negative (red)
      -- colors.yellow       -- Attention/accent (yellow)

      -- Diagnostic colors
      -- colors.error        -- Diagnostic error
      -- colors.warning      -- Diagnostic warning
      -- colors.info         -- Diagnostic information
      -- colors.hint         -- Diagnostic hint

      -- UI element colors
      -- colors.border       -- Border around windows/popup menus
      -- colors.cursorline   -- Background for the current line
      -- colors.selection    -- Background for selected text
      -- colors.statusline   -- Background/foreground for statusline
      -- colors.tabline      -- Background/foreground for tabline

      -- Custom/Other colors
      -- (These depend on user-defined settings or OneDarkPro configuration)
      -- colors.git          -- Colors for Git integrations
      -- colors.diff_add     -- Color for added lines in diff
      -- colors.diff_delete  -- Color for deleted lines in diff
      -- colors.diff_change  -- Color for changed lines in diff
      -- colors.diff_text    -- Text within a diff change

      -- vim.api.nvim_set_hl(0, "MiniTablineCurrent", { fg = colors.bg, bg = colors.blue, bold = true })
      -- vim.api.nvim_set_hl(0, "MiniTablineVisible", { fg = colors.fg, bg = colors.bg })
      -- vim.api.nvim_set_hl(0, "MiniTablineHidden", { fg = colors.gray, bg = colors.bg })
      -- vim.api.nvim_set_hl(0, "MiniTablineModifiedCurrent", { fg = colors.bg, bg = colors.red })
      -- vim.api.nvim_set_hl(0, "MiniTablineModifiedVisible", { fg = colors.fg, bg = colors.bg })
      -- vim.api.nvim_set_hl(0, "MiniTablineModifiedHidden", { fg = colors.gray, bg = colors.bg })
      -- vim.api.nvim_set_hl(0, "MiniTablineFill", { fg = colors.bg, bg = colors.bg_dark })
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

      -- Custom highlights
      -- local colors = require("onedarkpro.helpers").get_colors()
      -- vim.api.nvim_set_hl(0, "MiniStatuslineModeNormal", { fg = colors.bg, bg = colors.green, bold = true })
      -- vim.api.nvim_set_hl(0, "MiniStatuslineModeInsert", { fg = colors.bg, bg = colors.blue, bold = true })
      -- vim.api.nvim_set_hl(0, "MiniStatuslineModeCommand", { fg = colors.bg, bg = colors.purple, bold = true })
      -- vim.api.nvim_set_hl(0, "MiniStatuslineFilename", { fg = colors.blue, bg = colors.bg })
      --
      -- vim.api.nvim_set_hl(0, "MiniStatuslineMode", { fg = colors.bg, bg = colors.blue, bold = true })
      -- vim.api.nvim_set_hl(0, "MiniStatuslineDevinfo", { fg = colors.fg, bg = colors.bg_dark })
      -- vim.api.nvim_set_hl(0, "MiniStatuslineGit", { fg = colors.green, bg = colors.bg_dark })
      -- vim.api.nvim_set_hl(0, "MiniStatuslineDiagnostics", { fg = colors.red, bg = colors.bg_dark })
    end,
  },
}
