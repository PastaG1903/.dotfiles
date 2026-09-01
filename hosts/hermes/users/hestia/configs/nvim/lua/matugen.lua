 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#11162c',
    base01 = '#1c244a',
    base02 = '#192143',
    base03 = '#606470',
    base04 = '#afb0b6',
    base05 = '#f2f2f3',
    base06 = '#f2f2f3',
    base07 = '#f2f2f3',
    base08 = '#fd4663',
    base09 = '#b966cc',
    base0A = '#845cd6',
    base0B = '#677ee4',
    base0C = '#d996e9',
    base0D = '#93a3ec',
    base0E = '#b196e9',
    base0F = '#d0bef4',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#f2f2f3',          bg = '#11162c' })
  hi('TelescopeBorder',         { fg = '#606470',             bg = '#11162c' })
  hi('TelescopePromptNormal',   { fg = '#f2f2f3',          bg = '#11162c' })
  hi('TelescopePromptBorder',   { fg = '#606470',             bg = '#11162c' })
  hi('TelescopePromptPrefix',   { fg = '#677ee4',             bg = '#11162c' })
  hi('TelescopePromptCounter',  { fg = '#afb0b6',  bg = '#11162c' })
  hi('TelescopePromptTitle',    { fg = '#11162c',             bg = '#677ee4' })
  hi('TelescopePreviewTitle',   { fg = '#11162c',             bg = '#845cd6' })
  hi('TelescopeResultsTitle',   { fg = '#11162c',             bg = '#b966cc' })
  hi('TelescopeSelection',      { fg = '#f2f2f3',          bg = '#192143' })
  hi('TelescopeSelectionCaret', { fg = '#677ee4',             bg = '#192143' })
  hi('TelescopeMatching',       { fg = '#677ee4',             bold = true })
end

-- Register a signal handler for SIGUSR1 (matugen updates).
-- The handler re-requires this module, which re-runs the code below, so the
-- previous handle is stopped first; otherwise handlers double on every signal.
if _G.__matugen_signal then
  _G.__matugen_signal:stop()
  _G.__matugen_signal:close()
end

local signal = vim.uv.new_signal()
_G.__matugen_signal = signal
signal:start(
  'sigusr1',
  vim.schedule_wrap(function()
    package.loaded['matugen'] = nil
    require('matugen').setup()
  end)
)

return M
