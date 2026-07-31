 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#0a331f',
    base01 = '#115534',
    base02 = '#0f4c2f',
    base03 = '#697871',
    base04 = '#afb6b3',
    base05 = '#f2f3f2',
    base06 = '#f2f3f2',
    base07 = '#f2f3f2',
    base08 = '#fd4663',
    base09 = '#79ade4',
    base0A = '#79e3e4',
    base0B = '#76e7b0',
    base0C = '#95beea',
    base0D = '#93ecc0',
    base0E = '#95e9ea',
    base0F = '#910017',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#f2f3f2',          bg = '#0a331f' })
  hi('TelescopeBorder',         { fg = '#697871',             bg = '#0a331f' })
  hi('TelescopePromptNormal',   { fg = '#f2f3f2',          bg = '#0a331f' })
  hi('TelescopePromptBorder',   { fg = '#697871',             bg = '#0a331f' })
  hi('TelescopePromptPrefix',   { fg = '#76e7b0',             bg = '#0a331f' })
  hi('TelescopePromptCounter',  { fg = '#afb6b3',  bg = '#0a331f' })
  hi('TelescopePromptTitle',    { fg = '#0a331f',             bg = '#76e7b0' })
  hi('TelescopePreviewTitle',   { fg = '#0a331f',             bg = '#79e3e4' })
  hi('TelescopeResultsTitle',   { fg = '#0a331f',             bg = '#79ade4' })
  hi('TelescopeSelection',      { fg = '#f2f3f2',          bg = '#0f4c2f' })
  hi('TelescopeSelectionCaret', { fg = '#76e7b0',             bg = '#0f4c2f' })
  hi('TelescopeMatching',       { fg = '#76e7b0',             bold = true })
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
