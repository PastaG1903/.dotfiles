local M = {}

function M.setup()
  require('base16-colorscheme').setup {
    -- Backgrounds
    base00 = '#112c2a',           -- Default background
    base01 = '#1c4a46', -- Status bars, lighter bg
    base02 = '#19433f', -- Selection bg
    base03 = '#60756f',           -- Comments, invisibles

    -- Foregrounds
    base04 = '#afb6b4', -- Dark fg (status bars)
    base05 = '#f2f3f3',         -- Default fg
    base06 = '#f2f3f3',         -- Light fg
    base07 = '#f2f3f3',      -- Lightest fg

    -- Accents
    base08 = '#fd4663',              -- Variables, errors
    base09 = '#6680cc',           -- Integers, constants
    base0A = '#5cb8d6',          -- Classes, search bg
    base0B = '#67e4c4',            -- Strings, diff inserted
    base0C = '#96abe9', -- Regex, escape chars
    base0D = '#93ecd5',  -- Functions, methods
    base0E = '#96d4e9',-- Keywords, storage
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
