local M = {}

function M.setup()
  require('base16-colorscheme').setup {
    -- Backgrounds
    base00 = '#0a331f',           -- Default background
    base01 = '#115534', -- Status bars, lighter bg
    base02 = '#0f4c2f', -- Selection bg
    base03 = '#647a6f',           -- Comments, invisibles

    -- Foregrounds
    base04 = '#afb6b3', -- Dark fg (status bars)
    base05 = '#f2f3f2',         -- Default fg
    base06 = '#f2f3f2',         -- Light fg
    base07 = '#f2f3f2',      -- Lightest fg

    -- Accents
    base08 = '#fd4663',              -- Variables, errors
    base09 = '#79ade4',           -- Integers, constants
    base0A = '#79e3e4',          -- Classes, search bg
    base0B = '#76e7b0',            -- Strings, diff inserted
    base0C = '#95beea', -- Regex, escape chars
    base0D = '#93ecc0',  -- Functions, methods
    base0E = '#95e9ea',-- Keywords, storage
    base0F = '#900017',    -- Deprecated, embedded
  }
end

-- SIGUSR1 handler: reload theme live when Noctalia regenerates it
local signal = vim.uv.new_signal()
signal:start('sigusr1', vim.schedule_wrap(function()
  package.loaded['colors'] = nil
  require('colors').setup()
end))

return M
