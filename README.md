# dotfiles
make everything look nice :)

## Nvim ^0.7
Just a few steps to get everything going:
- Copy `init.vim` into `~/.config/nvim/`
- Install [Plug](https://github.com/junegunn/vim-plug)
- Enter Neovim and run `:PlugInstall`
- Language-specific LSPs must be installed manually. Treesitter support for a language can be installed via `:TSInstall [lang]`

## Fonts
- Main font (install it from nerdfonts.com): [FantasqueSansMono Nerd Font](https://www.nerdfonts.com/)
- Codicon (used for VSCode icons): [codicon.ttf](https://github.com/microsoft/vscode-codicons/blob/main/dist/codicon.ttf)

## Zsh
Install [Oh My Zsh](https://github.com/microsoft/vscode-codicons/blob/main/dist/codicon.ttf). \
Not much of a configuration for now, so didn't include the file. The theme used is called `flazz`.

## Qtile
Just a couple of changes. Nothing too fancy. \
Copy `config.py` to `~/.config/qtile/`.

## Rofi
Copy `config.rasi` to `~/.config/rofi/`. \
To call Rofi, hit `<M-r>` in Qtile.

## Tmux
Install [Tmux Plugin Manager](git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm). \
Two plugins only:
- Resurrect, for persisting sessions
- Themes! :)
