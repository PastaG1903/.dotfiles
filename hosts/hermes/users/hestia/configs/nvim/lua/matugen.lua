 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#03163a',
    base01 = '#0f2757',
    base02 = '#0b2350',
    base03 = '#5f656f',
    base04 = '#afb1b6',
    base05 = '#f2f2f3',
    base06 = '#f2f2f3',
    base07 = '#f2f2f3',
    base08 = '#fd4663',
    base09 = '#ba33ff',
    base0A = '#5cd679',
    base0B = '#4d89ff',
    base0C = '#d480ff',
    base0D = '#80aaff',
    base0E = '#96e9aa',
    base0F = '#bef4cb',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- telescope.nvim
  hi('TelescopeNormal',         { fg = '#f2f2f3',          bg = '#03163a' })
  hi('TelescopeBorder',         { fg = '#5f656f',             bg = '#03163a' })
  hi('TelescopePromptNormal',   { fg = '#f2f2f3',          bg = '#03163a' })
  hi('TelescopePromptBorder',   { fg = '#5f656f',             bg = '#03163a' })
  hi('TelescopePromptPrefix',   { fg = '#4d89ff',             bg = '#03163a' })
  hi('TelescopePromptCounter',  { fg = '#afb1b6',  bg = '#03163a' })
  hi('TelescopePromptTitle',    { fg = '#03163a',             bg = '#4d89ff' })
  hi('TelescopePreviewTitle',   { fg = '#03163a',             bg = '#5cd679' })
  hi('TelescopeResultsTitle',   { fg = '#03163a',             bg = '#ba33ff' })
  hi('TelescopeSelection',      { fg = '#f2f2f3',          bg = '#0b2350' })
  hi('TelescopeSelectionCaret', { fg = '#4d89ff',             bg = '#0b2350' })
  hi('TelescopeMatching',       { fg = '#4d89ff',             bold = true })

  -- mini.pick
  hi('MiniPickNormal',         { fg = '#f2f2f3',          bg = '#03163a' })
  hi('MiniPickBorder',         { fg = '#5f656f',             bg = '#03163a' })
  hi('MiniPickPrompt',   { fg = '#f2f2f3',          bg = '#03163a' })
  hi('MiniPickPromptPrefix',   { fg = '#4d89ff',             bg = '#03163a' })
  hi('MiniPickBorderText',    { fg = '#03163a',             bg = '#4d89ff' })
  hi('MiniPickMatchCurrent',      { fg = '#f2f2f3',          bg = '#0b2350' })
  hi('MiniPickPromptCaret', { fg = '#4d89ff',             bg = '#0b2350' })
  hi('MiniPickMatchRanges',       { fg = '#4d89ff',             bold = true })
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
