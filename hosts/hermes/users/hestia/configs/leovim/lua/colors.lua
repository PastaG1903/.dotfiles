local M = {}

function M.setup()
  require('base16-colorscheme').setup {
    -- Backgrounds
    base00 = '#29141b',           -- Default background
    base01 = '#45212c', -- Status bars, lighter bg
    base02 = '#3e1e28', -- Selection bg
    base03 = '#756167',           -- Comments, invisibles

    -- Foregrounds
    base04 = '#b6afb1', -- Dark fg (status bars)
    base05 = '#f3f2f2',         -- Default fg
    base06 = '#f3f2f2',         -- Light fg
    base07 = '#f3f2f2',      -- Lightest fg

    -- Accents
    base08 = '#a14361',              -- Variables, errors
    base09 = '#ad66cc',           -- Integers, constants
    base0A = '#d6725c',          -- Classes, search bg
    base0B = '#e4678f',            -- Strings, diff inserted
    base0C = '#d096e9', -- Regex, escape chars
    base0D = '#ec93af',  -- Functions, methods
    base0E = '#e9a596',-- Keywords, storage
    base0F = '#3c111e',    -- Deprecated, embedded
  }
end

-- SIGUSR1 handler: reload theme live when Noctalia regenerates it
local signal = vim.uv.new_signal()
signal:start('sigusr1', vim.schedule_wrap(function()
  package.loaded['colors'] = nil
  require('colors').setup()
end))

return M
