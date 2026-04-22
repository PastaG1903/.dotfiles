# Table Of Plugins

> [!WARNING]
> This is heavily outdated.
> Last updated in Dec 2024

Here you will find a table of plugins that leovim installs, their parents, purpose in the installation, and conditions for loading.

I categorize them in sections.



## Management

| Parent | Plugin    | Purpose        | Loads |
| ------ | --------- | -------------- | ----- |
| self   | lazy.nvim | plugin manager | START |

## UI

| Parent          | Plugin                | Purpose                  | Loads     |
| --------------- | --------------------- | ------------------------ | --------- |
| self            | onedarkpro.nvim       | theme                    | START     |
| self            | alpha-nvim            | Greeter                  | START     |
| self            | bufferline.nvim       | Buffer UI tab            | START     |
| bufferline.nvim | nvim-web-devicons     | icons on the bufferline  | Parent    |
| bufferline.nvim | vim-bbye.nvim         | tool for closing buffers | Parent    |
| self            | indent-blankline.nvim | indent guides            | START     |
| self            | lualine.nvim          | status bar (below)       | START     |
| self            | noice.nvim            | ui for cmd               | Very Lazy |
| noice.nvim      | nui.nvim              | ui components library    | Parent    |
| noice.nvim      | nvim-notify           | notification boxes       | Parent    |
| self            | which-key.nvim        | <leader> keymaps hints   | START     |
| self            | neo-tree.nvim         | file tree                | cmd, keys |

## Coding

LSP and parsers

| Parent         | Plugin               | Purpose                 | Loads  |
| -------------- | -------------------- | ----------------------- | ------ |
| self           | nvim-lspconfig       | lsp                     | START  |
| nvim-lspconfig | cmp-nvim-lsp         | lsp-cmp communication   | Parent |
| nvim-lspconfig | mason-lspconfig.nvim | lsp-mason communication | Parent |
| nvim-lspconfig | mason.nvim           | lsp installer/manager   | Parent |
| self           | gitsigns.nvim        | git add/remove on code  | START  |
| self           | vim-fugitive         | git integration         | START  |
| self           | nvim-colorizer.lua   | colored hex             | START  |
| self           | nvim-treesitter      | syntax highlighting     | START  |
| self           | conform.nvim         | autoformatter           | START  |

Navigation

| Parent         | Plugin                    | Purpose                             | Loads     |
| -------------- | ------------------------- | ----------------------------------- | --------- |
| self           | flash.nvim                | search functionalities              | Very Lazy |
| self           | telescope.nvim            | fzf file navigator                  | VimEnter  |
| telescope.nvim | plenary.nvim              | lua functions library               | Parent    |
| telescope.nvim | telescope-fzf-native.nvim | better fzf algorithm implementation | Parent    |
| telescope.nvim | telescope-ui-select.nvim  | It sets vim.ui.select to telescope  | Parent    |
| self           | vim-sleuth                | dynamic window adjusting            | START     |
| self           | vim-tmux-navigator        | tmux-nvim communication             | START     |

Autocompletion and Snippets

| Parent   | Plugin            | Purpose                      | Loads       |
| -------- | ----------------- | ---------------------------- | ----------- |
| self     | vimtex            | nvim-latex communication     | START       |
| self     | nvim-cmp          | autocompletion               | InsertEnter |
| nvim-cmp | cmp-path          | source for filesystem        | Parent      |
| nvim-cmp | cmp-vimtex        | source for vimtex            | tex files   |
| nvim-cmp | cmp_luasnip       | source for LuaSnip           | Parent      |
| nvim-cmp | friendly-snippets | common library of snippets   | Parent      |
| nvim-cmp | LuaSnip           | snippet engine               | Parent      |
| self     | nvim-autopairs    | close () [] {} automatically | InsertEnter |

## Disabled plugins

| Parent         | Plugin                    | Purpose                             | Loads |
| -------------- | ------------------------- | ----------------------------------- | ----- |
| self           | fidget.nvim               | animations for lsp                  | Never |
| nvim-lspconfig | mason-tool-installer.nvim | auto update mason-lsp installations | Never |
| neo-tree.nvim  | nvim-window-picker        | functions to get window id          | Never |
| self           | todo-comments.nvim        | highlight TODO comments             | Never |
| vim-fugitive   | vim-rhubarb               | github integration                  | Never |
