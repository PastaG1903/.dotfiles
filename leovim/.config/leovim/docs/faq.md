# Frequenty Asked Questions

## How do I keep multiple neovim configurations?

Neovim lets you lauch it with a different configuration file by using the [NVIM_APPNAME](https://neovim.io/doc/user/starting.html#%24NVIM_APPNAME) environmental variable when launching it with the command.

```bash
NVIM_APPNAME="leovim" nvim
```
This will look for a configuration file under `~/.config/leovim` . Using this, you can clone
```bash
git clone https://github.com/leogabac/leovim.git ~/.config/leovim
```
and make the alias 
```bash
alias leovim='NVIM_APPNAME="leovim" nvim'
```
Then `leovim` will launch this confguration while `nvim` will keep your default.


