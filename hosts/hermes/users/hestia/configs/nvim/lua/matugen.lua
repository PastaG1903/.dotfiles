 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#111f2c',
    base01 = '#1d3449',
    base02 = '#1a2e42',
    base03 = '#616a71',
    base04 = '#afb3b6',
    base05 = '#f2f2f3',
    base06 = '#f2f2f3',
    base07 = '#f2f2f3',
    base08 = '#fd4663',
    base09 = '#9866cc',
    base0A = '#5c5dd6',
    base0B = '#67a7e4',
    base0C = '#be96e9',
    base0D = '#93c0ec',
    base0E = '#9696e9',
    base0F = '#bebef4',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#f2f2f3',          bg = '#111f2c' })
  hi('TelescopeBorder',         { fg = '#616a71',             bg = '#111f2c' })
  hi('TelescopePromptNormal',   { fg = '#f2f2f3',          bg = '#111f2c' })
  hi('TelescopePromptBorder',   { fg = '#616a71',             bg = '#111f2c' })
  hi('TelescopePromptPrefix',   { fg = '#67a7e4',             bg = '#111f2c' })
  hi('TelescopePromptCounter',  { fg = '#afb3b6',  bg = '#111f2c' })
  hi('TelescopePromptTitle',    { fg = '#111f2c',             bg = '#67a7e4' })
  hi('TelescopePreviewTitle',   { fg = '#111f2c',             bg = '#5c5dd6' })
  hi('TelescopeResultsTitle',   { fg = '#111f2c',             bg = '#9866cc' })
  hi('TelescopeSelection',      { fg = '#f2f2f3',          bg = '#1a2e42' })
  hi('TelescopeSelectionCaret', { fg = '#67a7e4',             bg = '#1a2e42' })
  hi('TelescopeMatching',       { fg = '#67a7e4',             bold = true })
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
