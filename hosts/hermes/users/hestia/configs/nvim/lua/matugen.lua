 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#191e24',
    base01 = '#2a323c',
    base02 = '#262d36',
    base03 = '#616971',
    base04 = '#afb2b6',
    base05 = '#f2f2f3',
    base06 = '#f2f2f3',
    base07 = '#f2f2f3',
    base08 = '#fd4663',
    base09 = '#9e66cc',
    base0A = '#615cd6',
    base0B = '#67a0e4',
    base0C = '#c396e9',
    base0D = '#93bbec',
    base0E = '#9996e9',
    base0F = '#c0bef4',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- telescope.nvim
  hi('TelescopeNormal',         { fg = '#f2f2f3',          bg = '#191e24' })
  hi('TelescopeBorder',         { fg = '#616971',             bg = '#191e24' })
  hi('TelescopePromptNormal',   { fg = '#f2f2f3',          bg = '#191e24' })
  hi('TelescopePromptBorder',   { fg = '#616971',             bg = '#191e24' })
  hi('TelescopePromptPrefix',   { fg = '#67a0e4',             bg = '#191e24' })
  hi('TelescopePromptCounter',  { fg = '#afb2b6',  bg = '#191e24' })
  hi('TelescopePromptTitle',    { fg = '#191e24',             bg = '#67a0e4' })
  hi('TelescopePreviewTitle',   { fg = '#191e24',             bg = '#615cd6' })
  hi('TelescopeResultsTitle',   { fg = '#191e24',             bg = '#9e66cc' })
  hi('TelescopeSelection',      { fg = '#f2f2f3',          bg = '#262d36' })
  hi('TelescopeSelectionCaret', { fg = '#67a0e4',             bg = '#262d36' })
  hi('TelescopeMatching',       { fg = '#67a0e4',             bold = true })

  -- mini.pick
  hi('MiniPickNormal',         { fg = '#f2f2f3',          bg = '#191e24' })
  hi('MiniPickBorder',         { fg = '#616971',             bg = '#191e24' })
  hi('MiniPickPrompt',   { fg = '#f2f2f3',          bg = '#191e24' })
  hi('MiniPickPromptPrefix',   { fg = '#67a0e4',             bg = '#191e24' })
  hi('MiniPickBorderText',    { fg = '#191e24',             bg = '#67a0e4' })
  hi('MiniPickMatchCurrent',      { fg = '#f2f2f3',          bg = '#262d36' })
  hi('MiniPickPromptCaret', { fg = '#67a0e4',             bg = '#262d36' })
  hi('MiniPickMatchRanges',       { fg = '#67a0e4',             bold = true })
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
