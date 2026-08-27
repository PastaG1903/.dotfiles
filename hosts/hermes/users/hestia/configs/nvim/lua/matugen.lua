 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#112c2a',
    base01 = '#1c4a46',
    base02 = '#19433f',
    base03 = '#64746f',
    base04 = '#afb6b4',
    base05 = '#f2f3f3',
    base06 = '#f2f3f3',
    base07 = '#f2f3f3',
    base08 = '#fd4663',
    base09 = '#6680cc',
    base0A = '#5cb9d6',
    base0B = '#67e4c4',
    base0C = '#96abe9',
    base0D = '#93ecd5',
    base0E = '#96d5e9',
    base0F = '#8f0118',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#f2f3f3',          bg = '#112c2a' })
  hi('TelescopeBorder',         { fg = '#64746f',             bg = '#112c2a' })
  hi('TelescopePromptNormal',   { fg = '#f2f3f3',          bg = '#112c2a' })
  hi('TelescopePromptBorder',   { fg = '#64746f',             bg = '#112c2a' })
  hi('TelescopePromptPrefix',   { fg = '#67e4c4',             bg = '#112c2a' })
  hi('TelescopePromptCounter',  { fg = '#afb6b4',  bg = '#112c2a' })
  hi('TelescopePromptTitle',    { fg = '#112c2a',             bg = '#67e4c4' })
  hi('TelescopePreviewTitle',   { fg = '#112c2a',             bg = '#5cb9d6' })
  hi('TelescopeResultsTitle',   { fg = '#112c2a',             bg = '#6680cc' })
  hi('TelescopeSelection',      { fg = '#f2f3f3',          bg = '#19433f' })
  hi('TelescopeSelectionCaret', { fg = '#67e4c4',             bg = '#19433f' })
  hi('TelescopeMatching',       { fg = '#67e4c4',             bold = true })
end

 -- Register a signal handler for SIGUSR1 (matugen updates)
 local signal = vim.uv.new_signal()
 signal:start(
   'sigusr1',
   vim.schedule_wrap(function()
     package.loaded['matugen'] = nil
     require('matugen').setup()
   end)
 )

 return M
