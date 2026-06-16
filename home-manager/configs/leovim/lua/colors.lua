local M = {}

function M.setup()
  require('base16-colorscheme').setup {
    -- Backgrounds
    base00 = '#11162c',           -- Default background
    base01 = '#1c244a', -- Status bars, lighter bg
    base02 = '#192143', -- Selection bg
    base03 = '#5f6474',           -- Comments, invisibles

    -- Foregrounds
    base04 = '#afb0b6', -- Dark fg (status bars)
    base05 = '#f2f2f3',         -- Default fg
    base06 = '#f2f2f3',         -- Light fg
    base07 = '#f2f2f3',      -- Lightest fg

    -- Accents
    base08 = '#fd4663',              -- Variables, errors
    base09 = '#b966cc',           -- Integers, constants
    base0A = '#845cd6',          -- Classes, search bg
    base0B = '#677ee4',            -- Strings, diff inserted
    base0C = '#d996e9', -- Regex, escape chars
    base0D = '#93a3ec',  -- Functions, methods
    base0E = '#b196e9',-- Keywords, storage
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
