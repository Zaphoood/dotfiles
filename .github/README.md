# Dotfiles
I got the idea for managing my dotfiles this way from [this blogpost](https://www.ackama.com/what-we-think/the-best-way-to-store-your-dotfiles-a-bare-git-repository-explained/).

## Installing
Clone the repository
```
echo ".cfg" >> .gitignore
git clone https://github.com/Zaphoood/new-dotfiles $HOME/.cfg
```

Create an alias for managing the repository
```
alias dot-cfg='/usr/bin/git --git-dir=$HOME/.cfg/.git --work-tree=$HOME'
dot-cfg config --local status.showUntrackedFiles no
```

Download the wallpaper (see below) or any other wallpaper you like and put it in `$HOME/Pictures/wallpaper/`. You may need to change the path to the wallpaper in i3's config file accordingly.

Useful tip: If you have want to commit all tracked files with changes to them, use `dot-cfg add -u` (instead of the usual `dot-cfg add -A`).

## Stuff

Desktop environment

 * Window manager: [i3](https://i3wm.org/)
 * Compositor: [picom](https://github.com/yshui/picom)
 * Application launcher: [rofi](https://github.com/davatorium/rofi)
 * Status bar: [polybar](https://github.com/polybar/polybar)
 * Notification daemon: [dunst](https://dunst-project.org/)
 * Lock screen: [i3lock-color](https://github.com/Raymo111/i3lock-color)

Programs

 * Editor: [neovim](https://neovim.io/) with [vim-plug](https://github.com/junegunn/vim-plug) as a plugin manager
 * File exlporer: [ranger](https://github.com/ranger/ranger) with [Überzug](https://github.com/seebye/ueberzug)
 * Markdown viewer: [glow](https://github.com/charmbracelet/glow)
 * [ckb-next](https://github.com/ckb-next/ckb-next) for managing Corsair peripherals

Assets

 * Wallpaper: A [scene](https://wallpaperaccess.com/download/when-marnie-was-there-2298398) from the movie *When Marnie Was There*
 * Fonts: [DejaVu Sans Mono](https://www.fontsquirrel.com/fonts/dejavu-sans) and [Caskaydia Cove NF](https://eng.m.fontke.com/font/64992431/download/)

Other dependencies
 * [feh](https://feh.finalrewind.org/)
 * [dbus-send](https://linux.die.net/man/1/dbus-send)
 * [playerctl](https://github.com/altdesktop/playerctl)
 * [amixer](https://linux.die.net/man/1/amixer)

## Thanks
My rofi theme was inspired by [Eric Murphy's](https://github.com/ericmurphyxyz/archrice) dotfiles.
