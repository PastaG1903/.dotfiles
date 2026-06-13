local M = {}

function M.setup()
  require('base16-colorscheme').setup {
    -- Backgrounds
    base00 = '#03273a',           -- Default background
    base01 = '#0f3e57', -- Status bars, lighter bg
    base02 = '#0b3850', -- Selection bg
    base03 = '#617077',           -- Comments, invisibles

    -- Foregrounds
    base04 = '#afb4b6', -- Dark fg (status bars)
    base05 = '#f2f2f3',         -- Default fg
    base06 = '#f2f2f3',         -- Light fg
    base07 = '#f2f2f3',      -- Lightest fg

    -- Accents
    base08 = '#fd4663',              -- Variables, errors
    base09 = '#7c38fa',           -- Integers, constants
    base0A = '#5cd66d',          -- Classes, search bg
    base0B = '#51c0fb',            -- Strings, diff inserted
    base0C = '#ad83fc', -- Regex, escape chars
    base0D = '#82d2fc',  -- Functions, methods
    base0E = '#96e9a1',-- Keywords, storage
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
