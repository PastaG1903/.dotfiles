 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#03273a',
    base01 = '#0f3e57',
    base02 = '#0b3850',
    base03 = '#646f74',
    base04 = '#afb4b6',
    base05 = '#f2f2f3',
    base06 = '#f2f2f3',
    base07 = '#f2f2f3',
    base08 = '#fd4663',
    base09 = '#7c38fa',
    base0A = '#5cd66d',
    base0B = '#51c0fb',
    base0C = '#ad83fc',
    base0D = '#82d2fc',
    base0E = '#96e9a1',
    base0F = '#bef4c5',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- telescope.nvim
  hi('TelescopeNormal',         { fg = '#f2f2f3',          bg = '#03273a' })
  hi('TelescopeBorder',         { fg = '#646f74',             bg = '#03273a' })
  hi('TelescopePromptNormal',   { fg = '#f2f2f3',          bg = '#03273a' })
  hi('TelescopePromptBorder',   { fg = '#646f74',             bg = '#03273a' })
  hi('TelescopePromptPrefix',   { fg = '#51c0fb',             bg = '#03273a' })
  hi('TelescopePromptCounter',  { fg = '#afb4b6',  bg = '#03273a' })
  hi('TelescopePromptTitle',    { fg = '#03273a',             bg = '#51c0fb' })
  hi('TelescopePreviewTitle',   { fg = '#03273a',             bg = '#5cd66d' })
  hi('TelescopeResultsTitle',   { fg = '#03273a',             bg = '#7c38fa' })
  hi('TelescopeSelection',      { fg = '#f2f2f3',          bg = '#0b3850' })
  hi('TelescopeSelectionCaret', { fg = '#51c0fb',             bg = '#0b3850' })
  hi('TelescopeMatching',       { fg = '#51c0fb',             bold = true })

  -- mini.pick
  hi('MiniPickNormal',         { fg = '#f2f2f3',          bg = '#03273a' })
  hi('MiniPickBorder',         { fg = '#646f74',             bg = '#03273a' })
  hi('MiniPickPrompt',   { fg = '#f2f2f3',          bg = '#03273a' })
  hi('MiniPickPromptPrefix',   { fg = '#51c0fb',             bg = '#03273a' })
  hi('MiniPickBorderText',    { fg = '#03273a',             bg = '#51c0fb' })
  hi('MiniPickMatchCurrent',      { fg = '#f2f2f3',          bg = '#0b3850' })
  hi('MiniPickPromptCaret', { fg = '#51c0fb',             bg = '#0b3850' })
  hi('MiniPickMatchRanges',       { fg = '#51c0fb',             bold = true })
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
