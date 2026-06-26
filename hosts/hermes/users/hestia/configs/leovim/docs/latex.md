# LaTeX Configuration

This document has the purpose of giving you a guide on how to quickly use LEOVIM as an editor for LaTeX, then give a brief introduction to the parts that make it work, in case you want to replicate them yourself, then common instructions for further setup, and last a table of all of the custom snippets that I wrote myself.

## How to use it?

To use this configuration as a LaTeX editor, you need to have the following installed

1. All of the plugins from this configuration
2. A LaTeX distribution, e.g. [texlive](https://www.tug.org/texlive/).
3. The [Zathura](https://pwmt.org/projects/zathura/) Zathura PDF viewer (Recommended) with a package for PDF support.
   - If Zathura cannot be installed, check the configurations below.
   - Linux Users, visit the Zathura [Arch Wiki page](https://wiki.archlinux.org/title/Zathura).
4. (Optional) Setup the tree-sitter LaTeX parser

### Basic Usage

- Document compilation:
  Open your `main.tex` file and press `<leader>ll`. This will automathically open a Zathura process (if installed correctly). This is done once per session, compilation is done automaticaly afterwards whenever any of the dependencies of your project is rewritten.
  To stop continuous compilation, press the keymap again.

There are many motions available for LaTeX, I suggest you read the guide: [Getting started with the VimTex plugin](https://ejmastnak.com/tutorials/vim-latex/vimtex/).

- Cleaning Auxiliary files:
  Press `<leader>lc` to clean auxiliary files.

- Using snippets and autocompletion:
  When on insert mode, you will notice autocompletion suggestions as you write. To navigate them use the arrow keys, or `C-n` and `C-p`. To select a suggestion press `ENTER`, and `<tab>` or `S-<tab>` to jump within a snippet.

When a document is compiled, and you are inside `\cite{}`, the suggestions will come from your list of references.

## How does it work?

In case you want an in-depth explanation, you can follow [this guide](https://ejmastnak.com/tutorials/vim-latex/intro/) by Elijan Mastnak. Here I will simply explain the logic of what is needed for this setup to work which are the following:

1. A way to communicate Neovim with the LaTeX compiler.

   This is done with the [vimtex](https://github.com/lervag/vimtex) plugin. It provides much more than simple compilation, and I encourage you to read the guide mentioned above.

2. An completion engine, and sources.

   This is done with the popular [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) plugin. This is a general purpose completion engine, and by default it has completion capabilities through _onmifunc_. However, to have access to what vimtex compiles, such as references, we add as a source of completion [vimtex-cmp](https://github.com/micangl/cmp-vimtex).

   Additionally, we add typical sources for _nvim-cmp_ that might be useful for completing paths and code blocks.

3. A Snippet Engine.

   The snippet engine is used to add preconfigured blocks of text while writting, e.g. when you start typing _fig_ and press ENTER, it will fill for you the whole figure environment with pre-defined options. For this we use [LuaSnip](https://github.com/L3MON4D3/LuaSnip), and add it as a completion source for _nvim-cmp_. Furthermore, LuaSnip lets you write your own snippets, which I did to shorten some common things I write. It is important to note that most of the snippets come from [friendly-snippets](https://github.com/rafamadriz/friendly-snippets).


## Common setups

### Tree-Sitter parser

The tree-sitter parser for LaTeX needs manual intervention to be set up. 

1. Install the `tree-sitter-cli` and make it visible to PATH. Package name will depend on on your distribution.
2. Install `nodejs` and make it visible to PATH. This is needed to compile the parser.
3. Run in neovim `:TSInstall latex`


### Changing PDF viewer

In case you don't like or couldn't install Zathura on your system. To change it and avoid the

> Zathura is not executtable!

message. Go to the file `./lua/plugins/misc.lua` and change the line

```
vim.g.vimtex_view_method = "zathura"
```

to make vimtex use your PDF viewer of choice.


## Table Of Snippets
WIP
